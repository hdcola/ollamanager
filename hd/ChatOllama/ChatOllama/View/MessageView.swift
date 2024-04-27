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

struct MessageView: View {
    var lm: [Dialogue]
    @Namespace var bottomID
    var body: some View {
        ScrollView {
            ScrollViewReader { proxy in
                VStack(alignment: .leading) {
                    ForEach(lm, id: \.self) { dialogue in
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
                .onChange(of:lm, initial: false) { _,_  in
                    proxy.scrollTo(bottomID, anchor: .bottom)
                }
            }
        }
        .padding()
    }
}


#Preview {
    MessageView(lm: [Dialogue(query: "Hello", response: "Hi")])
}
