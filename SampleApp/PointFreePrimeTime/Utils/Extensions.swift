//
//  Extensions.swift
//  Utils
//
//  Created by Luiz Rodrigo Martins Barbosa on 15.03.20.
//  Copyright © 2020 Point-Free. All rights reserved.
//

import Combine
import Foundation

extension Publisher where Output == Never, Failure == Never {
    public func fireAndForget<A>() -> AnyPublisher<A, Never> {
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

public func absurd<A>(_ never: Never) -> A {}

public func setter<Root, Value>(_ keyPath: WritableKeyPath<Root, Value>) -> (inout Root, Value) -> Void {
    return { root, value in
        root[keyPath: keyPath] = value
    }
}
