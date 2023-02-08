//
//  ChannelStack.Previews.swift
//  
//
//  Created by Jaesung Lee on 2023/02/09.
//

import SwiftUI

struct ChannelStack_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            Preview()
                .environmentObject(
                    ChatConfiguration(
                        userID: "andrew_parker",
                        giphyKey: "wj5tEh9nAwNHVF3ZFavQ0zoaIyt8HZto"
                    )
                )
        }
    }
    
    struct Preview: View {
        @State private var messages: [Message] = [
            Message.message5,
            Message.message4,
            Message.message2,
            Message.message1,
        ]
        
        var body: some View {
            ChannelStack(GroupChannel.channel1) {
                MessageList(messages) { message in
                    MessageRow(
                        message: message,
                        showsUsername: false
                    )
                    .padding(.top, 12)
                }
                
                MessageField(isMenuItemPresented: .constant(false)) {
                    messages.insert(
                        Message(
                            id: UUID().uuidString,
                            sender: User.user1,
                            sentAt: Date().timeIntervalSince1970,
                            readReceipt: .sending,
                            style: $0
                        ),
                        at: 0
                    )
                }
            }
        }
    }
}
