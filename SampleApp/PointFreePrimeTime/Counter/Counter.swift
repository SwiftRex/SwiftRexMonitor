import Combine
import CombineRex
import PrimeModal
import SwiftRex
import SwiftUI
import Utils

public enum CounterAction: Equatable {
    case decrTapped
    case incrTapped
    case nthPrimeButtonTapped
    case nthPrimeResponse(Int?)
    case alertDismissButtonTapped
    case isPrimeButtonTapped
    case primeModalDismissed
}

public typealias CounterState = (
    alertNthPrime: PrimeAlert?,
    count: Int,
    isNthPrimeButtonDisabled: Bool,
    isPrimeModalShown: Bool
)

public final class CounterMiddleware: Middleware {
    public typealias InputActionType = CounterAction
    public typealias OutputActionType = CounterAction
    public typealias StateType = Int

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
        case .nthPrimeButtonTapped:
            afterReducer = .do {
                Current.nthPrime(self.getState())
                    .map(CounterAction.nthPrimeResponse)
                    .receive(on: DispatchQueue.main)
                    .sink { [weak self] action in
                        self?.output?.dispatch(action)
                    }.store(in: &self.cancellables)
            }

        case .decrTapped,
             .incrTapped,
             .nthPrimeResponse,
             .alertDismissButtonTapped,
             .isPrimeButtonTapped,
             .primeModalDismissed:
            break
        }
    }
}

let counterReducer = Reducer<CounterAction, CounterState> { action, state in
    var state = state
    switch action {
    case .decrTapped:
        state.count -= 1
        return state
    case .incrTapped:
        state.count += 1
        return state
    case .nthPrimeButtonTapped:
        state.isNthPrimeButtonDisabled = true
        return state
    case let .nthPrimeResponse(prime):
        state.alertNthPrime = prime.map(PrimeAlert.init(prime:))
        state.isNthPrimeButtonDisabled = false
        return state
    case .alertDismissButtonTapped:
        state.alertNthPrime = nil
        return state
    case .isPrimeButtonTapped:
        state.isPrimeModalShown = true
        return state
    case .primeModalDismissed:
        state.isPrimeModalShown = false
        return state
    }
}

struct CounterEnvironment {
    var nthPrime: (Int) -> AnyPublisher<Int?, Never>
}

extension CounterEnvironment {
    static let live = CounterEnvironment(nthPrime: Counter.nthPrime)
}

var Current = CounterEnvironment.live // swiftlint:disable:this identifier_name

extension CounterEnvironment {
    static let mock = CounterEnvironment(nthPrime: { _ in .sync { 17 } })
}

import CasePaths

public let counterViewReducer: Reducer<CounterViewAction, CounterViewState> =
    counterReducer.lift(
        actionGetter: /CounterViewAction.counter,
        stateGetter: { $0.counter },
        stateSetter: setter(\CounterViewState.counter)
    ) <> primeModalReducer.lift(
        actionGetter: /CounterViewAction.primeModal,
        stateGetter: { $0.primeModal },
        stateSetter: setter(\CounterViewState.primeModal)
    )

public struct PrimeAlert: Equatable, Identifiable, Encodable {
    let prime: Int
    public var id: Int { self.prime }
}

public struct CounterViewState: Equatable {
    public var alertNthPrime: PrimeAlert?
    public var count: Int
    public var favoritePrimes: [Int]
    public var isNthPrimeButtonDisabled: Bool
    public var isPrimeModalShown: Bool

    public init(
        alertNthPrime: PrimeAlert? = nil,
        count: Int = 0,
        favoritePrimes: [Int] = [],
        isNthPrimeButtonDisabled: Bool = false,
        isPrimeModalShown: Bool = false
    ) {
        self.alertNthPrime = alertNthPrime
        self.count = count
        self.favoritePrimes = favoritePrimes
        self.isNthPrimeButtonDisabled = isNthPrimeButtonDisabled
        self.isPrimeModalShown = isPrimeModalShown
    }

    var counter: CounterState {
        get { (self.alertNthPrime, self.count, self.isNthPrimeButtonDisabled, self.isPrimeModalShown) }
        set { (self.alertNthPrime, self.count, self.isNthPrimeButtonDisabled, self.isPrimeModalShown) = newValue }
    }

    var primeModal: PrimeModalState {
        get { (self.count, self.favoritePrimes) }
        set { (self.count, self.favoritePrimes) = newValue }
    }
}

public enum CounterViewAction: Equatable {
    case counter(CounterAction)
    case primeModal(PrimeModalAction)
}

public struct CounterView: View {
    @ObservedObject var store: ObservableViewModel<CounterViewAction, CounterViewState>

    public init(store: ObservableViewModel<CounterViewAction, CounterViewState>) {
        self.store = store
    }

    public var body: some View {
        VStack {
            HStack {
                Button("-") { self.store.dispatch(.counter(.decrTapped)) }
                Text("\(self.store.state.count)")
                Button("+") { self.store.dispatch(.counter(.incrTapped)) }
            }
            Button("Is this prime?") { self.store.dispatch(.counter(.isPrimeButtonTapped)) }
            Button("What is the \(ordinal(self.store.state.count)) prime?") {
                self.store.dispatch(.counter(.nthPrimeButtonTapped))
            }
            .disabled(self.store.state.isNthPrimeButtonDisabled)
        }
        .font(.title)
        .navigationBarTitle("Counter demo")
        .sheet(
            isPresented: .constant(self.store.state.isPrimeModalShown),
            onDismiss: { self.store.dispatch(.counter(.primeModalDismissed)) },
            content: {
                IsPrimeModalView(
                    store: self.store.projection(
                        action: { .primeModal($0) },
                        state: { ($0.count, $0.favoritePrimes) }
                    ).asObservableViewModel(
                        initialState: (0, []),
                        emitsValue: .when { lhs, rhs in
                            lhs.count != rhs.count || lhs.favoritePrimes != rhs.favoritePrimes
                        }
                    )
                )
            }
        )
        .alert(
            item: .constant(self.store.state.alertNthPrime)
        ) { alert in
            Alert(
                title: Text("The \(ordinal(self.store.state.count)) prime is \(alert.prime)"),
                dismissButton: .default(Text("Ok")) {
                    self.store.dispatch(.counter(.alertDismissButtonTapped))
                }
            )
        }
    }
}

func ordinal(_ n: Int) -> String {
    let formatter = NumberFormatter()
    formatter.numberStyle = .ordinal
    return formatter.string(for: n) ?? ""
}
