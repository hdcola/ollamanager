//
//  MessageViewModel.swift
//  ChatOllama
//
//  Created by Danny on 2024-04-27.
//

//
//  File.swift
//
//
//  Created by Sicheng Jiang on 2024-04-06.
//

import SwiftUI
import OllamaKit
import Combine
import SwiftData

@Observable
class MessageViewModel {
    private var modelContext: ModelContext
    private let ollamaKit = OllamaKit(baseURL: URL(string: "http://localhost:11434")!)

    var message = ""
    var model = ""
    var isCompleted = true
    var errorMessage = ""
    var reply = ""
    var lastMessages: [Dialogue] = []
    
    var cancellable = Set<AnyCancellable>()
    
    init(modelContext: ModelContext) {
        self.modelContext = modelContext
    }
    
    func fetch() throws{
        let fetchDescription = FetchDescriptor<Dialogue>()
        lastMessages = try modelContext.fetch(fetchDescription)
    }
    
    func sendMessage() {
        isCompleted = false
        errorMessage = ""
        let dialogue = Dialogue(query: message, response: "")
        lastMessages.append(dialogue)
        modelContext.insert(dialogue)
        try? modelContext.saveChanges()
        let request = OKGenerateRequestData(model: model, prompt: message)
        ollamaKit.generate(data: request)
            .sink(
                receiveCompletion: { completion in
                    switch completion {
                    case .finished:
                        self.isCompleted = true
                        self.reply = ""
                        self.message = ""
                        try? self.modelContext.saveChanges()
                    case .failure(let error):
                        self.errorMessage = error.localizedDescription
                        try? self.modelContext.saveChanges()
                    }
                }, receiveValue: { gresponse in
                    self.reply += gresponse.response
                    self.lastMessages[self.lastMessages.count-1].response = self.reply
                }
            )
            .store(in: &cancellable)
    }
    
    func sendButton(sendingMessage: String, usedModel: String) {
        if isCompleted {
            if !sendingMessage.isEmpty {
                message = sendingMessage
                model = usedModel
                sendMessage()
            }
        } else {
            cancellable.removeAll()
            reply = ""
            message = ""
            isCompleted = true
        }
    }
    
}


