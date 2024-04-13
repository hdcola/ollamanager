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
    var body: some View {
        ForEach(lm, id: \.self.response) { dialogue in
            Text("You:")
                .font(.title3)
                .foregroundColor(.blue)
            Text(dialogue.query)
                .frame(alignment:.leading)
            Text("Reply:")
                .font(.title3)
                .foregroundColor(.blue)
            Text(dialogue.response)
                .frame(alignment:.leading)
            Divider()
        }
        Image(systemName: "ellipsis.bounce.down.byLayer")
    }
}

