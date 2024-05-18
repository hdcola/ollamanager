//
//  PreviewContainer.swift
//  ChatOllama
//
//  Created by Sicheng Jiang on 2024-05-18.
//

import SwiftData
import SwiftUI

@MainActor
let previewContainer: ModelContainer = {
    do {
        let container = try ModelContainer(for: Dialogue.self, configurations: ModelConfiguration(isStoredInMemoryOnly: true))
        container.mainContext.insert(Dialogue(query: "lalala", response: "lololol"))
        return container
    } catch {
        fatalError("womp womp")
    }
}()
