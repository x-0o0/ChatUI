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
        
        private let appearance = Appearance()
        
        @Environment(\.colorScheme) var colorScheme
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
                            appearance.images.getCamera(colorScheme).medium
                        }
                        .frame(width: 36, height: 36)
                        
                        Button(action: {}) {
                            appearance.images.getPhotoLibrary(colorScheme).medium
                        }
                        .frame(width: 36, height: 36)
                        
                        Button(action: {}) {
                            appearance.images.getMic(colorScheme).medium
                        }
                        .frame(width: 36, height: 36)
                    }
                } rightLabel: {
                    Button {
                        sendMessagePublisher.send(.text(text))
                    } label: {
                        appearance.images.getSend(colorScheme).medium
                    }
                    .frame(width: 36, height: 36)
                }
                .environment(\.appearance, appearance)
                
            }
        }
    }

}


