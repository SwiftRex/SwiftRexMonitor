import Foundation

extension Result {
    public var success: Success? {
        get {
            guard case let .success(value) = self else { return nil }
            return value
        }
        set {
            guard case .success = self, let newValue = newValue else { return }
            self = .success(newValue)
        }
    }

    public var isSuccess: Bool {
        self.success != nil
    }

    public var failure: Failure? {
        get {
            guard case let .failure(value) = self else { return nil }
            return value
        }
        set {
            guard case .failure = self, let newValue = newValue else { return }
            self = .failure(newValue)
        }
    }

    public var isFailure: Bool {
        self.failure != nil
    }
}
