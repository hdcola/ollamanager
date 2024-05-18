//
//  ChatView.swift
//  ChatOllama
//
//  Created by Sicheng Jiang on 2024-04-27.
//

import SwiftUI
import SwiftData

struct ChatView: View {
    @State var vm = ChatViewModel()
    @State var mvm = MessageViewModel()
    @Query var dialogues: [Dialogue]
    @AppStorage("selectedModel") var selectedModel = ""
    let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    @State var message = ""
    var body: some View {
        VStack {
            MessageView(lm: dialogues)
            Spacer()
            HStack {
                TextField("Message", text: $message)
                    .textFieldStyle(.roundedBorder)
                    .disableAutocorrection(true)
                    .disabled(!mvm.isCompleted)
                    .onSubmit {
                        sendMessage()
                    }
                Button {
                    sendMessage()
                } label: {
                    Image(systemName:mvm.isCompleted ? "arrow.up" : "stop.fill")
                        .font(.title)
                }
                .disabled(message.isEmpty && mvm.isCompleted)
            }
            HStack {
                Text("Status:")
                Image(systemName: "circle.fill")
                    .foregroundColor(vm.reachable ? .green : .red)
                Picker("Model",selection: $vm.selectedModel){
                    Text("Select a model")
                    ForEach(vm.availModels, id: \.self.name) {
                        Text($0.name)
                    }
                }
                .pickerStyle(.menu)
                .padding()
                .onReceive(timer) { _ in
                    Task {
                        await vm.checkReachable()
                        await vm.getModels()
                    }
                }
                
            }
        }
    }
    func sendMessage() {
        mvm.sendButton(sendingMessage: message, usedModel: vm.selectedModel)
        message = ""
    }
}

#Preview {
    ChatView()
        .frame(minWidth: 200, minHeight: 400)
        .modelContainer(previewContainer)
}
