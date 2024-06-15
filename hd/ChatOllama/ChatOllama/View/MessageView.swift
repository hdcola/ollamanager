//
//  MessageView.swift
//  ChatOllama
//
//  Created by Danny on 2024-04-27.
//

//
//  MessageView.swift
//  ollamanager
//
//  Created by Sicheng Jiang on 2024-04-06.
//

import SwiftUI
import SwiftData

struct MessageView: View {
    @Environment(MessageViewModel.self) private var mvm
    @Namespace var bottomID
    var body: some View {
        ScrollView {
            ScrollViewReader { proxy in
                VStack(alignment: .leading) {
                    ForEach(mvm.lastMessages) { dialogue in
                        Text("You:")
                            .font(.title3)
                            .foregroundColor(.blue)
                        Text(dialogue.query)
                            .frame(alignment:.leading)
                            .multilineTextAlignment(.leading)
                        Divider()
                        Text("Reply:")
                            .font(.title3)
                            .foregroundColor(.blue)
                        Text(dialogue.response)
                            .frame(alignment:.leading)
                            .multilineTextAlignment(.leading)
                        Divider()
                    }
                    Image(systemName: "one of the most stupid pieces of code ever written")
                        .id(bottomID)
                }
                .onChange(of:mvm.lastMessages, initial: false) { _,_  in
                    proxy.scrollTo(bottomID, anchor: .bottom)
                }
            }
        }
        .padding()
    }
}

//
//#Preview {
//    MessageView(lm: [Dialogue(query: "Hello", response: "Hi")])
//}
