import SwiftUI

@available(iOS 17.0, *)
struct ContentView: View {
    @State var vm = ContentViewModel()
    @State var mvm = MessageViewModel()
    @AppStorage("selectedModel") var selectedModel = ""
    let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    @State var message = ""
    @State var lastSentMessage = ""
    var body: some View {
        VStack {
            Text("You:")
                .font(.title3)
                .foregroundColor(.blue)
            Text(lastSentMessage)
                .frame(alignment:.leading)
            Text("Reply:")
                .font(.title3)
                .foregroundColor(.blue)
            Text(mvm.isCompleted ? mvm.reply : mvm.reply + "...")
            Spacer()
            HStack{
                TextField("Message", text: $message)
                    .textFieldStyle(.roundedBorder)
                    .disableAutocorrection(true)
                    .textInputAutocapitalization(.never)
                    .onSubmit {
                        mvm.message = message
                        mvm.model = vm.selectedModel
                        mvm.sendMessage()
                        lastSentMessage = message
                        message = ""
                    }
                    .disabled(!mvm.isCompleted)
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
            }
        }
        .onReceive(timer) { _ in
            Task {
                await vm.checkReachable()
                await vm.getModels()
            }
        }
    }
        
}
