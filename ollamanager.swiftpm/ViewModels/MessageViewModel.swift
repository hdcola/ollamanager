//
//  File.swift
//
//
//  Created by Sicheng Jiang on 2024-04-06.
//

import SwiftUI
import OllamaKit
import Combine

@available(iOS 17.0, *)
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

struct Dialogue: Equatable, Hashable {
    var query: String
    var response: String
}
