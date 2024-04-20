import SwiftUI

@available(iOS 17.0, *)
struct ContentView: View {
    @State var vm = ContentViewModel()
    @State var mvm = MessageViewModel()
    @AppStorage("selectedModel") var selectedModel = ""
    let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    @State var message = ""
    var body: some View {
        VStack {
            MessageView(isCompleted: mvm.isCompleted, lm: mvm.lastMessages)
            Spacer()
            HStack {
                TextField("Message", text: $message)
                    .textFieldStyle(.roundedBorder)
                    .disableAutocorrection(true)
                    .textInputAutocapitalization(.never)
                    .disabled(!mvm.isCompleted)
                    .onSubmit {
                        sendMessage()
                    }
                Button {
                    sendMessage()
                } label: {
                    Image(systemName:mvm.isCompleted ? "arrow.up.square.fill" : "stop.circle.fill")
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
