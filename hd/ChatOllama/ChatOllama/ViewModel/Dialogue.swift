//
//  Dialogue.swift
//  ChatOllama
//
//  Created by Danny on 2024-05-18.
//

import SwiftData

@Model
class Dialogue {
    var query: String
    var response: String
    init(query: String, response: String) {
        self.query = query
        self.response = response
    }
}
