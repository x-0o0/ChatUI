//
//  MessageList.Previews.swift
//  
//
//  Created by Jaesung Lee on 2023/02/08.
//

import SwiftUI

struct MessageList_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            NavigationView {
                Preview()
            }
            .previewDisplayName("With Message Field and Navigation")

            MessageList([Message.message1, Message.message2, Message.message3]) { message in
                Menu {
                    Button {
                        // Add this item to a list of favorites.
                    } label: {
                        Label("Add to Favorites", systemImage: "heart")
                    }
                    Button {
                        // Open Maps and center it on this item.
                    } label: {
                        Label("Show in Maps", systemImage: "mappin")
                    }
                } label: {
                    MessageRow(message: message)
                }
            }
            .previewDisplayName("Message List")
        }
        .environmentObject(
            ChatConfiguration(
                userID: User.user1.id,
                giphyKey: "wj5tEh9nAwNHVF3ZFavQ0zoaIyt8HZto"
            )
        )
    }
    
    struct Preview: View {
        @Environment(\.appearance) var appearance
        
        @State private var messages: [Message] = [
            Message.message1, Message.message2, Message.message3
        ]
        
        var body: some View {
            VStack(spacing: 0) {
                MessageList(messages) { message in
                    MessageRow(message: message)
                        .onTapGesture(count: 1) {
                            withAnimation {
                                switch message.readReceipt {
                                case .failed:
                                    messages.removeAll { $0.id == message.id }
                                default:
                                    messages.removeAll { $0.id == message.id }
                                }
                            }
                        }
                }
                
                MessageField {
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
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    HStack {
                        AsyncImage(url: User.user1.imageURL) { image in
                            image
                                .resizable()
                                .frame(width: 36, height: 36)
                                .aspectRatio(contentMode: .fill)
                                .clipShape(Circle())
                                .padding(1)
                                .background {
                                    appearance.border
                                        .clipShape(Circle())
                                }
                        } placeholder: {
                            Image(systemName: "person.crop.circle.fill")
                                .resizable()
                                .frame(width: 36, height: 36)
                                .aspectRatio(contentMode: .fill)
                                .foregroundColor(.secondary)
                                .clipShape(Circle())
                        }
                        
                        VStack(alignment: .leading) {
                            Text(User.user1.username)
                                .font(.headline)
                            
                            Text(User.user1.id)
                                .font(.footnote)
                                .foregroundColor(.secondary)
                        }
                    }
                }
            }
        }
    }
}
