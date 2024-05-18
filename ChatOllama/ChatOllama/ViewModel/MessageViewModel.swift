//
//  MessageViewModel.swift
//  ChatOllama
//
//  Created by Sicheng Jiang on 2024-04-27.
//

import SwiftUI
import OllamaKit
import Combine
import SwiftData

@Observable
class MessageViewModel {
    private let ollamaKit = OllamaKit(baseURL: URL(string: "http://localhost:11434")!)

    var message = ""
    var model = ""
    var isCompleted = true
    var errorMessage = ""
    var reply = ""
    var lastMessages: [Dialogue] = []
    
    var cancellable = Set<AnyCancellable>()
    
    func sendMessage() {
        isCompleted = false
        errorMessage = ""
        lastMessages.append(Dialogue(query: message, response: ""))
        print(lastMessages)
        let request = OKGenerateRequestData(model: model, prompt: message)
        ollamaKit.generate(data: request)
            .sink(
                receiveCompletion: { completion in
                    switch completion {
                    case .finished:
                        self.isCompleted = true
                        self.reply = ""
                        self.message = ""
                    case .failure(let error):
                        self.errorMessage = error.localizedDescription
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

@Model
class Dialogue {
    var query: String
    var response: String
    
    init(query: String, response: String) {
        self.query = query
        self.response = response
    }
}
