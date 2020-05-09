import SwiftRexMonitorEngine
import SwiftUI

struct ConnectedAppListView: View {
    @ObservedObject var viewModel: ConnectedAppListPresenter.ViewModel

    var body: some View {
        List {
            Section(header: Text(viewModel.state.header)) {
                ForEach(self.viewModel.state.apps) { app in
                    NavigationLink(
                        destination: self.viewModel.state.router(()),
                        tag: app.id,
                        selection: .store(
                            self.viewModel,
                            stateMap: \.selectedApp,
                            onChange: ConnectedAppListEvent.changeAppSelection
                        )
                    ) {
                        HStack {
                            Text(verbatim: app.name)
                                .font(.system(.body))

                            Button(
                                action: { self.viewModel.dispatch(.copy(app.stringForPasteboard)) },
                                label: { Text(verbatim: self.viewModel.state.jsonButtonCaption) }
                            )
                            .font(.system(.caption))
                            .layoutPriority(0.1)

                        }
                    }
                }
            }
        }.frame(minWidth: 250, maxWidth: 350)
    }
}

#if DEBUG

struct ConnectedAppListViewPreviews: PreviewProvider {
    static var previews: some View {
        ConnectedAppListView(viewModel: .mock(state: .init(
            header: "Connected apps",
            selectedApp: nil,
            apps: [
                .init(id: 1, name: "Test app 1", state: "Bla", stringForPasteboard: "")
            ],
            router: .empty,
            jsonButtonCaption: ""
        )))
    }
}

#endif
