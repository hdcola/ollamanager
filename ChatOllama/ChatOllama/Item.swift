//
//  Item.swift
//  ChatOllama
//
//  Created by Sicheng Jiang on 2024-04-27.
//

import Foundation
import SwiftData

@Model
final class Item {
    var timestamp: Date
    
    init(timestamp: Date) {
        self.timestamp = timestamp
    }
}
