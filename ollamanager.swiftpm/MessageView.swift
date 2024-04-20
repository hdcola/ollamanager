//
//  MessageView.swift
//  ollamanager
//
//  Created by Sicheng Jiang on 2024-04-06.
//

import SwiftUI

struct MessageView: View {
    var isCompleted: Bool
    var lm: [Dialogue]
    @Namespace var bottomID
    var body: some View {
        ScrollView {
            ScrollViewReader { proxy in
                VStack(alignment: .leading) {
                    ForEach(lm, id: \.self.response) { dialogue in
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
                .onChange(of:lm) { _ in
                    withAnimation {
                        proxy.scrollTo(bottomID, anchor: .bottom)
                    }
                }
            }
        }
        .padding()
    }
}
