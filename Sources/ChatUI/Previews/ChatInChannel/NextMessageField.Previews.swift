//
//  NextMessageField.Previews.swift
//
//
//  Created by Jaesung Lee on 2023/08/02.
//

import SwiftUI

struct NextMessageField_Previews: PreviewProvider {
    static var previews: some View {
        Preview()
            .previewDisplayName("Next Message Field")
    }
    
    struct Preview: View {
        @State private var pendingMessage: Message?
        @State private var text: String = ""
        
        var body: some View {
            VStack {
                if let pendingMessage = pendingMessage {
                    Text(pendingMessage.id)
                    
                    Text(String(describing: pendingMessage.style))
                }
                
                Spacer()
                
                NextMessageField($text) { messageStyle in
                    pendingMessage = Message(
                        id: UUID().uuidString,
                        sender: User.user1,
                        sentAt: Date().timeIntervalSince1970,
                        readReceipt: .sending,
                        style: messageStyle
                    )
                } leftLabel: {
                    HStack {
                        Button(action: {}) {
                            Image.camera.medium
                        }
                        .frame(width: 36, height: 36)
                        
                        Button(action: {}) {
                            Image.photoLibrary.medium
                        }
                        .frame(width: 36, height: 36)
                        
                        Button(action: {}) {
                            Image.mic.medium
                        }
                        .frame(width: 36, height: 36)
                    }
                } rightLabel: {
                    Button {
                        sendMessagePublisher.send(.text(text))
                    } label: {
                        Image.send.medium
                    }
                    .frame(width: 36, height: 36)
                }
                .environment(\.appearance, Appearance())
                
            }
        }
    }

}

