import Foundation
import MultipeerConnectivity

// sourcery: EnumCodable=EncodeOnly
// sourcery: Prism
public enum MultipeerSessionMessagingAction {
    case startMonitoring
    case stoppedMonitoring
    case gotData(Data, from: Peer)
    case sendData(Data)
    case sendDataToPeer(Data, to: Peer)
    case sendDataResult(Data, to: Peer?, /* sourcery: CustomEncoder=encodeResult */ result: Result<Void, Error>)

    func encodeResult(_ result: Result<Void, Error>) -> String {
        switch result {
        case .success: return ".success(())"
        case let .failure(error): return ".failure(\(error.localizedDescription))"
        }
    }
}
