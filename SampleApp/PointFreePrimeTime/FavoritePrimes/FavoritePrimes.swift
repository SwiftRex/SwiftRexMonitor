import Combine
import SwiftRex
import SwiftUI

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
                    .save("favorite-primes.json", try! JSONEncoder().encode(self.getState()))
                    .fireAndForget()
                    .sink { }
                    .store(in: &self.cancellables)
            }

        case .loadButtonTapped:
            afterReducer = .do {
                Current.fileClient.load("favorite-primes.json")
                    .compactMap { $0 }
                    .decode(type: [Int].self, decoder: JSONDecoder())
                    .catch { error in Empty(completeImmediately: true) }
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

extension Publisher where Output == Never, Failure == Never {
    func fireAndForget<A>() -> AnyPublisher<A, Never> {
        return self.map(absurd).eraseToAnyPublisher()
    }
}

extension Publisher where Failure == Never {
    public static func fireAndForget(work: @escaping () -> Void) -> AnyPublisher<Output, Never> {
        return Deferred { () -> Empty<Output, Never> in
            work()
            return Empty(completeImmediately: true)
        }.eraseToAnyPublisher()
    }

    public static func sync(work: @escaping () -> Output) -> AnyPublisher<Output, Never> {
        return Deferred {
            Just(work())
        }.eraseToAnyPublisher()
    }
}

func absurd<A>(_ never: Never) -> A {}

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
                try! data.write(to: favoritePrimesUrl)
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

var Current = FavoritePrimesEnvironment.live

#if DEBUG
extension FavoritePrimesEnvironment {
    static let mock = FavoritePrimesEnvironment(
        fileClient: FileClient(
            load: { _ in AnyPublisher<Data?, Never>.sync {
                try! JSONEncoder().encode([2, 31])
                } },
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
