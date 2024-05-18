//
//  ChatOllamaApp.swift
//  ChatOllama
//
//  Created by Sicheng Jiang on 2024-04-27.
//

import SwiftUI
import SwiftData

@main
struct ChatOllamaApp: App {
    var sharedModelContainer: ModelContainer = {
        let schema = Schema([
            Dialogue.self,
        ])
        let modelConfiguration = ModelConfiguration(schema: schema, isStoredInMemoryOnly: false)

        do {
            return try ModelContainer(for: schema, configurations: [modelConfiguration])
        } catch {
            fatalError("Could not create ModelContainer: \(error)")
        }
    }()

    var body: some Scene {
        WindowGroup {
            ChatView()
                .frame(minWidth: 100, minHeight: 400)
        }
        .modelContainer(sharedModelContainer)
    }
}
