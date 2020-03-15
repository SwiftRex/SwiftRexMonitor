import CombineRex
import SwiftRex
import SwiftUI
import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    var window: UIWindow?
    let store = ReduxStoreBase(
        subject: .combine(initialValue: AppState()),
        reducer: appReducer,
        middleware: appMiddleware,
        emitsValue: .whenDifferent
    )

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        if let windowScene = scene as? UIWindowScene {
            let window = UIWindow(windowScene: windowScene)
            window.rootViewController = UIHostingController(
                rootView: ContentView(
                    store: store.asObservableViewModel(initialState: .init(), emitsValue: .whenDifferent)
                )
            )
            self.window = window
            window.makeKeyAndVisible()
        }
    }
}
