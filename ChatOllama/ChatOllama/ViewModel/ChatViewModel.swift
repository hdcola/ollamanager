//
//  ContentViewModel.swift
//  ChatOllama
//
//  Created by Sicheng Jiang on 2024-04-27.
//

import SwiftUI
import OllamaKit

@available(iOS 17.0, *)
@Observable
class ChatViewModel {
    private let ollamaKit = OllamaKit(baseURL: URL(string: "http://localhost:11434")!)
    
    var reachable = false
    var selectedModel: String {
        get {
            return UserDefaults.standard.string(forKey: "selectedModel") ?? ""
        }
        set {
            UserDefaults.standard.setValue(newValue, forKey: "selectedModel")
        }
    }
    var availModels: [OKModelResponse.Model] = []
    
    func checkReachable() async {
        reachable = await ollamaKit.reachable()
    }
    func getModels() async {
        do {
            availModels = try await ollamaKit.models().models
        } catch {
            
        }
        
    }
}
