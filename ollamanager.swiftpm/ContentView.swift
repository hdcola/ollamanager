import SwiftUI

@available(iOS 17.0, *)
struct ContentView: View {
    @Bindable var vm = ContentViewModel()
    @State private var model = ""
    let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    var body: some View {
        VStack {
            HStack {
                Text("Status:")
                Image(systemName: "circle.fill")
                    .foregroundColor(vm.reachable ? .green : .red)
            }
            HStack {
                Picker("Model",selection: $model){
                    Text("Select a model")
                    ForEach(vm.availModels, id: \.self.name) {
                        Text($0.name)
                    }
                }
            }
            Text("Input")
            Text("Response")
            Text(model)
        }
        .onReceive(timer) { _ in
            Task {
                await vm.checkReachable()
                await vm.getModels()
            }
        }
    }
        
}
