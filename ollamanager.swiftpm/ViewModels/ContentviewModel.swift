//
//  File.swift
//  
//
//  Created by Sicheng Jiang on 2024-03-30.
//

import SwiftUI
import OllamaKit

@available(iOS 17.0, *)
@Observable
class ContentViewModel {
    private let ollamaKit = OllamaKit(baseURL: URL(string: "http://localhost:11434")!)
    
    var reachable = false
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
