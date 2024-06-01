//
//  ModelContext.swift
//  ChatOllama
//
//  Created by Danny on 2024-05-25.
//

import SwiftData

extension ModelContext{
    func saveChanges() throws{
        if self.hasChanges {
            try self.save()
        }
    }
}
