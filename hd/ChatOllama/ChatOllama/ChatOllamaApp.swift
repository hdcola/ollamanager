//
//  ChatOllamaApp.swift
//  ChatOllama
//
//  Created by Danny on 2024-04-27.
//

import SwiftUI
import SwiftData

@main
struct ChatOllamaApp: App {
    @State private var messageViewModel : MessageViewModel
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
    
    init(){
        let modelContext = sharedModelContainer.mainContext
        
        let messageViewModel = MessageViewModel(modelContext: modelContext)
        _messageViewModel = State(initialValue: messageViewModel)
    }

    var body: some Scene {
        WindowGroup {
            ChatView()
                .environment(messageViewModel)
                .frame(minWidth: 400,minHeight: 400)
        }
        .modelContainer(sharedModelContainer)
    }
}
