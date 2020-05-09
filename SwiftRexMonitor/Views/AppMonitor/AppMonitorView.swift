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
        ScrollView(.vertical, showsIndicators: true) {
            VStack(alignment: .leading) {
                Text(viewModel.state.name)
                    .font(.system(.title))

                GenericObjectView(key: nil, genericObject: viewModel.state.state).id(UUID())

                Spacer()
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .padding()
        }
    }
}

private struct GenericObjectView: View {
    let key: String?
    let genericObject: GenericObject

    var body: some View {
        genericObjectViewBuilder()
    }

    func genericObjectViewBuilder() -> AnyView {
        switch genericObject {
        case let .array(items):
            return ForEach((0..<items.count), id: \.self) { index in
                GenericObjectView(key: nil, genericObject: items[index])
            }
            .padding()
            .overlay(
                RoundedRectangle(cornerRadius: 8).stroke(Color.black, lineWidth: 2)
            )
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .eraseToAnyView()
        case let .genericObject(objects):
            return ForEach(objects, id: \.key) { item in
                GenericObjectView(key: item.key, genericObject: item.value)
            }
            .padding()
            .overlay(
                RoundedRectangle(cornerRadius: 8).stroke(Color.black, lineWidth: 2)
            )
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .eraseToAnyView()
        case let .bool(bool):
            return Toggle(isOn: .constant(bool)) { Text("\(key ?? "")") }.eraseToAnyView()
        case let .double(double):
            return Text(verbatim: "\(key ?? ""): \(double)").eraseToAnyView()
        case let .uuid(uuid):
            return Text(verbatim: "\(key ?? ""): \(uuid)").eraseToAnyView()
        case let .int(int):
            return Text(verbatim: "\(key ?? ""): \(int)").eraseToAnyView()
        case let .string(string):
            return Text(verbatim: "\(key ?? ""): \(string)").eraseToAnyView()
        case .null:
            return Text(verbatim: "\(key ?? ""): <null>").eraseToAnyView()
        }
    }
}
