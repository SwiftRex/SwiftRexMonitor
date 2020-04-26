import Foundation

/*
 Pipe forward application operator
 |>

 Apply function
 - Left: value a: A
 - Right: function A to B
 - Return: value b: B

 * left associativity
 * precedence group: Forward Application
 */
infix operator |>: ForwardApplication
precedencegroup ForwardApplication {
    associativity: left
    higherThan: AssignmentPrecedence
}

/*
 Forward composition operator / Right arrow operator
 >>>

 Compose two functions when output of the left matches input type of the right
 - Left: function A to B
 - Right: function B to C
 - Return: function A to C

 * left associativity
 * precedence group: Forward Composition
 * Forward Composition > Forward Application
 */
infix operator >>>: ForwardComposition
precedencegroup ForwardComposition {
    associativity: left
    higherThan: ForwardApplication
}

precedencegroup ApproximateEquality {
    associativity: left
    lowerThan: ComparisonPrecedence
    higherThan: LogicalConjunctionPrecedence
}

precedencegroup ToleranceRange {
    associativity: left
    lowerThan: AdditionPrecedence
    higherThan: ApproximateEquality
}

infix operator ±: ToleranceRange
infix operator ≅: ApproximateEquality
