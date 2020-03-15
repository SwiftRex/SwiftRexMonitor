import Foundation

extension Collection {
    subscript(safe index: Self.Index) -> Element? {
        return indices.contains(index) ? self[index] : nil
    }
}
