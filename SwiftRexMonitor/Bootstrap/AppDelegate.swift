import Cocoa
import Combine
import MultipeerConnectivity
import SwiftRex
import SwiftUI

@NSApplicationMain
class AppDelegate: NSObject, NSApplicationDelegate {
    var window: NSWindow!

    func applicationDidFinishLaunching(_ aNotification: Notification) {
        let store = World.live.store()
        store.dispatch(.monitorEngine(.start))

        let contentView = HomeView(viewModel: HomePresenter.viewModel(dependencies: (), router: mainViewProducer(store), store: store))

        // Create the window and set the content view. 
        window = NSWindow(
            contentRect: NSRect(x: 0, y: 0, width: 480, height: 300),
            styleMask: [.titled, .closable, .miniaturizable, .resizable, .fullSizeContentView],
            backing: .buffered, defer: false)
        window.center()
        window.setFrameAutosaveName("Main Window")
        window.contentView = NSHostingView(rootView: contentView)
        window.makeKeyAndOrderFront(nil)
    }

    func applicationWillTerminate(_ aNotification: Notification) {
        // Insert code here to tear down your application
    }
}

var mainViewProducer: (AnyStoreType<AppAction, AppState>) -> ViewProducer<NavigationTree> {
    return { store in
        ViewProducer { route in
            switch route {
            case let .home(selected):
                return ConnectedAppListView(
                    viewModel: ConnectedAppListPresenter.viewModel(
                        dependencies: (),
                        router: selected.map(appMonitorViewProducer(store)) ?? .empty,
                        store: store
                    )
                ).eraseToAnyView()
            }
        }
    }
}

var appMonitorViewProducer: (AnyStoreType<AppAction, AppState>) -> (Int) -> ViewProducer<Void> {
    return { store in
        return { selected in
            ViewProducer { id in
                AppMonitorView(viewModel: AppMonitorPresenter
                    .viewModel(
                        dependencies: (),
                        router: .empty,
                        store: store.projection(
                            action: { $0 },
                            state: { $0.monitorEngine.monitoredPeers.first(where: { $0.id == selected }) }
                        )
                    )
                ).eraseToAnyView()
            }
        }
    }
}
