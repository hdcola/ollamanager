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
    
    var cancellable = Set<AnyCancellable>()
    
    func sendMessage() {
        isCompleted = false
        errorMessage = ""
        let request = OKGenerateRequestData(model: model, prompt: message)
        ollamaKit.generate(data: request)
            .sink(
                receiveCompletion: { completion in
                    switch completion {
                    case .finished:
                        self.isCompleted = true
                    case .failure(let error):
                        self.errorMessage = error.localizedDescription
                    }
                }, receiveValue: { gresponse in
                    self.reply += gresponse.response
                }
            )
            .store(in: &cancellable)
    }
    
}
