import Foundation
import SwiftRex

let monitorReducer = Reducer<MonitorAction, [MonitoredPeer]> { action, state in
    switch action {
    case .start:
        return state
    case .peerListNeedsRefresh:
        return state
    case let .peerListHasChanged(connectedPeers):
        // Check peers in state that are not in connectedPeers, and mark them as isConnected = false
        let statePeers: [MonitoredPeer] = state.map {
            var peerInState = $0
            peerInState.isConnected = connectedPeers.contains(where: { $0.peerInstance.displayName == peerInState.peer.peerInstance.displayName })
            return peerInState
        }

        // Check for connected peers that are not yet in the state and add them as MonitoredPeer
        let newClients = connectedPeers.filter { connectedPeer in
            !statePeers.contains(where: { peerInState in peerInState.peer.peerInstance.displayName == connectedPeer.peerInstance.displayName })
        }.map { MonitoredPeer(peer: $0, isConnected: true, metadata: nil, history: []) }

        return statePeers + newClients
    case .evaluateData:
        return state
    case let .gotGreetings(greetings, initialState, initialStateData, peer):
        return state.map {
            guard $0.peer.peerInstance.displayName == peer.peerInstance.displayName else { return $0 }

            var peerInState = $0
            peerInState.metadata = greetings
            peerInState.history = [
                .init(
                    id: UUID(),
                    remoteDate: Date.distantPast,
                    action: "Initial State",
                    state: initialState,
                    stateData: initialStateData,
                    actionSource: .init(file: "N/A", function: "N/A", line: 0, info: nil)
                )
            ]
            return peerInState
        }
    case let .gotAction(action, remoteDate, newState, newStateData, actionSource, peer):
        return state.map {
            guard $0.peer.peerInstance.displayName == peer.peerInstance.displayName else { return $0 }

            var peerInState = $0
            peerInState.history.append(.init(
                id: UUID(),
                remoteDate: remoteDate,
                action: action,
                state: newState,
                stateData: newStateData,
                actionSource: actionSource
            ))
            return peerInState
        }
    }
}
