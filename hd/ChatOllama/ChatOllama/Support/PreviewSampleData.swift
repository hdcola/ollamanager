//
//  PreviewContainer.swift
//  ChatOllama
//
//  Created by Danny on 2024-05-18.
//

import SwiftData

@MainActor
let previewContainer: ModelContainer = {
    do {
        let container = try ModelContainer(for: Dialogue.self, configurations: ModelConfiguration(isStoredInMemoryOnly: true))
        let context = container.mainContext
        if try context.fetch(FetchDescriptor<Dialogue>()).isEmpty{
            SampleDialogur.contents.forEach { context.insert($0)}
        }
        return container
    } catch {
        fatalError("Failed to create container")
    }
}()

@MainActor
let mvm = MessageViewModel(modelContext: previewContainer.mainContext)
