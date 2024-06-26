//
//  Dialogue.swift
//  ChatOllama
//
//  Created by Danny on 2024-05-18.
//

import SwiftData
import Foundation

@Model
class Dialogue : Identifiable{
    var id: UUID
    var query: String
    var response: String
    init(query: String, response: String) {
        self.query = query
        self.response = response
        self.id = UUID()
    }
}


extension Dialogue: Hashable{
    static func == (lhs: Dialogue, rhs: Dialogue) -> Bool{
        lhs.query == rhs.query &&
        lhs.response == rhs.response
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(query)
        hasher.combine(response)
    }
}

