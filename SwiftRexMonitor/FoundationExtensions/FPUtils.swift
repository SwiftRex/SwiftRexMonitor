import Foundation

public func identity<A>(_ a: A) -> A {
    return a
}

public func identity<A, B>(_ a: A, _ b: B) -> (A, B) {
    return (a, b)
}

public func absurd<A>(_ never: Never) -> A { }

public func curry<A, B, C>(_ fn: @escaping (A, B) -> C) -> ((A) -> ((B) -> C)) {
    return { a in { b in fn(a, b) } }
}

public func uncurry<A, B, C>(_ fn: @escaping (A) -> ((B) -> C)) -> ((A, B) -> C) {
    return { (a, b) in fn(a)(b) }
}

public func flip<A, B, C>(_ fn: @escaping (A, B) -> C) -> ((B, A) -> C) {
    return { b, a in fn(a, b) }
}

public func run<A>(_ fn: @escaping () -> A) -> A {
    return fn()
}

public func partialApply<A, B, C>(_ fn: @escaping (A, B) -> C, _ a: A) -> ((B) -> C) {
    return curry(fn)(a)
}

public func const<A, B>(_ b: B) -> ((A) -> B) {
    return { _ in b }
}

public func lazy<A>(_ a: A) -> () -> A {
    return { a }
}

public func ignore<A>(_ a: A) {
    return ()
}

public func ignore<A>(of type: A.Type) -> (A) -> Void { { _ in () }
}

public func setter<Root, Value>(_ keyPath: WritableKeyPath<Root, Value>) -> (inout Root, Value) -> Void {
    return { root, value in
        root[keyPath: keyPath] = value
    }
}
