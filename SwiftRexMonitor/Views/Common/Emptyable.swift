//
//  Emptyable.swift
//  SwiftRexMonitor
//
//  Created by Luiz Rodrigo Martins Barbosa on 27.04.20.
//  Copyright © 2020 DeveloperCity. All rights reserved.
//

import Foundation

public protocol Emptyable {
    static var empty: Self { get }
}
