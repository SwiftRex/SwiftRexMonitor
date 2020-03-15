import Combine
import Foundation
import SwiftRex

//public final class MonitoredAppMiddleware: Middleware {
//    public typealias InputActionType = <#MyInputAction#>
//    public typealias OutputActionType = <#MyOutputAction#>
//    public typealias StateType = <#MyState#>
//
//    private let <#dependency1#>: () -> <#DependencyType1#>
//    private let <#dependency2#>: () -> <#DependencyType2#>
//    private var output: AnyActionHandler<OutputActionType>?
//    private var getState: GetState<StateType>?
//    private var cancellables = Set<AnyCancellable>()
//
//    public init(
//        <#dependency1#>: @escaping () -> <#DependencyType1#>,
//        <#dependency2#>: @escaping () -> <#DependencyType2#>
//    ) {
//        self.<#depedency1#> = <#depedency1#>
//        self.<#depedency2#> = <#depedency2#>
//    }
//
//    public func receiveContext(getState: @escaping GetState<StateType>, output: AnyActionHandler<OutputActionType>) {
//        self.getState = getState
//        self.output = output
//    }
//
//    public func handle(action: InputActionType, from dispatcher: ActionSource, afterReducer: inout AfterReducer) {
//        switch action {
//        case .<#start#>:
//            <#start#>()
//        }
//    }
//
//    private func <#start#>() {
//    }
//}
