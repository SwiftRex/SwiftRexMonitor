//
//  ViewProducer.swift
//  SwiftRexMonitor
//
//  Created by Luiz Rodrigo Martins Barbosa on 09.05.20.
//  Copyright © 2020 DeveloperCity. All rights reserved.
//

import SwiftRexMonitorEngine
import SwiftUI

/// Wrapper that contains a function mapping a Screen type to a ViewType.
/// Can be used in ViewModels to map navigation anchor points to their views.
public struct ViewProducer<NavigationBranch>: Equatable {
    @Transient private var viewProducerTransient: (NavigationBranch) -> AnyView

    public init(_ fn: @escaping (NavigationBranch) -> AnyView) {
        _viewProducerTransient = .init(fn)
    }

    public func callAsFunction(_ route: NavigationBranch) -> AnyView {
        viewProducerTransient(route)
    }
}

extension ViewProducer: Emptyable {
    public static var empty: ViewProducer<NavigationBranch> {
        ViewProducer { _ in
            EmptyView().eraseToAnyView()
        }
    }
}

extension View {
    /// Returns an `AnyView` wrapping this view.
    public func eraseToAnyView() -> AnyView {
        AnyView(self)
    }
}
