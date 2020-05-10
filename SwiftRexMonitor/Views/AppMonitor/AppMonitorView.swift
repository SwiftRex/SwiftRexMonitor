import MonitoredAppMiddleware
import SwiftUI

struct AppMonitorView: View {
    @ObservedObject var viewModel: AppMonitorPresenter.ViewModel

    var body: some View {
        ViewBuilder.buildIf(
            viewModel.state.isValid
                ? validBody()
                : nil
        )
    }

    private func validBody() -> some View {
        ScrollView([.horizontal, .vertical], showsIndicators: true) {
            GenericObjectView(
                genericObject: .genericObject([
                    .init(key: viewModel.state.name, value: viewModel.state.state)
                ])
            )
            .frame(maxWidth: .infinity, maxHeight: .infinity)
        }
    }
}

private struct GenericObjectView: View {
    let genericObject: GenericObject

    var body: some View {
        genericObjectViewBuilder()
    }

    func genericObjectViewBuilder() -> AnyView {
        switch genericObject {
        case let .array(items):
            return VStack(alignment: .leading) {
                ForEach((0..<items.count), id: \.self) { index in
                    GenericObjectView(genericObject: items[index])
                }
            }
            .padding()
            .overlay(
                RoundedRectangle(cornerRadius: 8).stroke(Color.black, lineWidth: 1)
            )
            .eraseToAnyView()
        case let .genericObject(objects):
            return VStack(alignment: .leading, spacing: 8) {
                ForEach(objects, id: \.key) { item in
                    HStack(alignment: .top, spacing: 8) {
                        Text(verbatim: item.key + ":").fixedSize()

                        GenericObjectView(genericObject: item.value)
                    }
                }
            }
            .padding()
            .overlay(
                RoundedRectangle(cornerRadius: 8).stroke(Color.black, lineWidth: 1)
            )
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .eraseToAnyView()

        case let .bool(bool):
            return Toggle("", isOn: .constant(bool)).eraseToAnyView()
        case let .double(double):
            return Text(verbatim: String(double)).fixedSize().eraseToAnyView()
        case let .uuid(uuid):
            return Text(verbatim: uuid.uuidString).fixedSize().eraseToAnyView()
        case let .int(int):
            return Text(verbatim: String(int)).fixedSize().eraseToAnyView()
        case let .string(string):
            return Text(verbatim: string).fixedSize().eraseToAnyView()
        case .null:
            return Text(verbatim: "<null>").fixedSize().eraseToAnyView()
        }
    }
}

#if DEBUG

struct AppMonitorViewPreviews: PreviewProvider {
    static var previews: some View {
        AppMonitorView(viewModel: .mock(state: .init(
            id: 1,
            name: "Some App",
            state: .genericObject([
                .init(key: "Is On", value: .bool(true)),
                .init(key: "Count", value: .int(4)),
                .init(key: "Favorites", value: .array([
                    .int(3),
                    .int(5),
                    .int(7),
                    .int(9)
                ])),
                .init(key: "User", value: .genericObject([
                    .init(key: "ID", value: .uuid(.init())),
                    .init(key: "Name", value: .string("John")),
                    .init(key: "Password", value: .string("$3cR3t")),
                    .init(key: "Admin", value: .bool(true)),
                    .init(key: "Token", value: .null),
                ]))
            ]),
            isValid: true
        )))
    }
}

#endif
