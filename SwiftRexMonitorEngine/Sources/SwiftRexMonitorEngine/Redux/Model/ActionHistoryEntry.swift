//
//  ActionHistoryEntry.swift
//  SwiftRexMonitor
//
//  Created by Luiz Rodrigo Martins Barbosa on 26.04.20.
//  Copyright © 2020 DeveloperCity. All rights reserved.
//

import Foundation
import MonitoredAppMiddleware
import SwiftRex

public struct ActionHistoryEntry: Codable, Equatable, Identifiable {
    public let id: UUID
    public let remoteDate: Date
    public let action: String
    public let state: GenericObject?
    public let actionSource: ActionSource
}
