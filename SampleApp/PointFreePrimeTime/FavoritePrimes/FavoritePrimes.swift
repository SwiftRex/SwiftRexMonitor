import Combine
import SwiftRex
import SwiftUI
import Utils

public enum FavoritePrimesAction: Equatable {
    case deleteFavoritePrimes(IndexSet)
    case loadButtonTapped
    case loadedFavoritePrimes([Int])
    case saveButtonTapped
}

public final class FavoritePrimesMiddleware: Middleware {
    public typealias InputActionType = FavoritePrimesAction
    public typealias OutputActionType = FavoritePrimesAction
    public typealias StateType = [Int]

    private var output: AnyActionHandler<OutputActionType>?
    private var getState: GetState<StateType>!
    private var cancellables = Set<AnyCancellable>()

    public init() {
    }

    public func receiveContext(getState: @escaping GetState<StateType>, output: AnyActionHandler<OutputActionType>) {
        self.getState = getState
        self.output = output
    }

    public func handle(action: InputActionType, from dispatcher: ActionSource, afterReducer: inout AfterReducer) {
        switch action {
        case .deleteFavoritePrimes: break
        case .loadedFavoritePrimes: break
        case .saveButtonTapped:
            afterReducer = .do {
                Current.fileClient
                    .save("favorite-primes.json", try! JSONEncoder().encode(self.getState())) // swiftlint:disable:this force_try
                    .fireAndForget()
                    .sink { }
                    .store(in: &self.cancellables)
            }

        case .loadButtonTapped:
            afterReducer = .do {
                Current.fileClient.load("favorite-primes.json")
                    .compactMap { $0 }
                    .decode(type: [Int].self, decoder: JSONDecoder())
                    .catch { _ in Empty(completeImmediately: true) }
                    .map(FavoritePrimesAction.loadedFavoritePrimes)
                    .sink { [weak self] action in
                        self?.output?.dispatch(action)
                    }.store(in: &self.cancellables)
            }
        }
    }
}

public let favoritePrimesReducer = Reducer<FavoritePrimesAction, [Int]> { action, state in
    switch action {
    case let .deleteFavoritePrimes(indexSet):
        var state = state
        for index in indexSet {
            state.remove(at: index)
        }
        return state
    case let .loadedFavoritePrimes(favoritePrimes): return favoritePrimes
    case .saveButtonTapped: return state
    case .loadButtonTapped: return state
    }
}

struct FileClient {
    var load: (String) -> AnyPublisher<Data?, Never>
    var save: (String, Data) -> AnyPublisher<Never, Never>
}

extension FileClient {
    static let live = FileClient(
        load: { fileName -> AnyPublisher<Data?, Never> in
            .sync {
                let documentsPath = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0]
                let documentsUrl = URL(fileURLWithPath: documentsPath)
                let favoritePrimesUrl = documentsUrl.appendingPathComponent(fileName)
                return try? Data(contentsOf: favoritePrimesUrl)
            }
        },
        save: { fileName, data in
            return .fireAndForget {
                let documentsPath = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0]
                let documentsUrl = URL(fileURLWithPath: documentsPath)
                let favoritePrimesUrl = documentsUrl.appendingPathComponent(fileName)
                try! data.write(to: favoritePrimesUrl) // swiftlint:disable:this force_try
            }
        }
    )
}

struct FavoritePrimesEnvironment {
    var fileClient: FileClient
}
extension FavoritePrimesEnvironment {
    static let live = FavoritePrimesEnvironment(fileClient: .live)
}

var Current = FavoritePrimesEnvironment.live // swiftlint:disable:this identifier_name

#if DEBUG
extension FavoritePrimesEnvironment {
    static let mock = FavoritePrimesEnvironment(
        fileClient: FileClient(
            load: { _ in AnyPublisher<Data?, Never>.sync {
                try! JSONEncoder().encode([2, 31]) // swiftlint:disable:this force_try
            }
            },
            save: { _, _ in .fireAndForget {} }
        )
    )
}
#endif

import CombineRex

public struct FavoritePrimesView: View {
    @ObservedObject var store: ObservableViewModel<FavoritePrimesAction, [Int]>

    public init(store: ObservableViewModel<FavoritePrimesAction, [Int]>) {
        self.store = store
    }

    public var body: some View {
        List {
            ForEach(self.store.state, id: \.self) { prime in
                Text("\(prime)")
            }
            .onDelete { indexSet in
                self.store.dispatch(.deleteFavoritePrimes(indexSet))
            }
        }
        .navigationBarTitle("Favorite primes")
        .navigationBarItems(
            trailing: HStack {
                Button("Save") {
                    self.store.dispatch(.saveButtonTapped)
                }
                Button("Load") {
                    self.store.dispatch(.loadButtonTapped)
                }
            }
        )
    }
}
