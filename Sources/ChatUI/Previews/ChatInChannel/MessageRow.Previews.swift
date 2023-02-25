//
//  MessageRow.Previews.swift
//  
//
//  Created by Jaesung Lee on 2023/02/08.
//

import SwiftUI

struct MessageRow_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            // MARK: - Message Rows
            ScrollView(showsIndicators: false) {
                LazyVStack {
                    /// **General**
                    MessageRow(message: Message.message3)
                    
                    /// Hide **username**
                    MessageRow(
                        message: Message.message3,
                        showsUsername: false
                    )
                    
                    /// Hide **date**
                    MessageRow(
                        message: Message.message3,
                        showsUsername: false,
                        showsDate: false
                    )
                    
                    /// Hide **profileImage**
                    MessageRow(
                        message: Message.message3,
                        showsUsername: false,
                        showsDate: false,
                        showsProfileImage: false
                    )
                    
                    Divider()
                    
                    /// **General**
                    MessageRow(
                        message: Message.message7
                    )
                    
                    /// Hide **username**
                    MessageRow(
                        message: Message.message7,
                        showsUsername: false
                    )
                    
                    /// Hide **date**
                    MessageRow(
                        message: Message.message7,
                        showsUsername: false,
                        showsDate: false
                    )
                    
                    /// Hide **profileImage**
                    MessageRow(
                        message: Message.message7,
                        showsUsername: false,
                        showsDate: false,
                        showsProfileImage: false
                    )
                    
                    /// Hide **read recipt**
                    MessageRow(
                        message: Message.message7,
                        showsUsername: false,
                        showsDate: false,
                        showsProfileImage: false,
                        showsReadReceiptStatus: false
                    )
                }
            }
            .previewDisplayName("Message Rows")
            
            // MARK: - Read Recipt
            ScrollView(showsIndicators: false) {
                LazyVStack {
                    /// **Sending Message**
                    MessageRow(
                        message: Message.message9,
                        showsUsername: false
                    )
                    
                    /// **Failed Message**
                    MessageRow(
                        message: Message.message8,
                        showsUsername: false
                    )
                    
                    /// **Sent Message**
                    MessageRow(
                        message: Message.message6,
                        showsUsername: false
                    )
                    
                    /// **Delivered Message**
                    MessageRow(
                        message: Message.message7,
                        showsUsername: false
                    )
                    
                    /// **Seen Message**
                    MessageRow(
                        message: Message.message2
                    )
                }
            }
            .previewDisplayName("Read Recipt")
            
            // MARK: - Message Style
            ScrollView(showsIndicators: false) {
                LazyVStack {
                    /// **Text Message**
                    /// ``MessageStyle/text(_:)``
                    MessageRow(message: Message.message2)
                    
                    /// **Location Message**
                    /// ``MessageStyle/media(_:)``, ``MediaType/location(_:_:)``
                    MessageRow(message: Message.locationMessage)
                    
                    /// **Photo Message**
                    /// ``MessageStyle/media(_:)``, ``MediaType/photo(_:)``
                    MessageRow(message: Message.photoMessage)
                    
                    /// **Failed Photo Message**
                    MessageRow(message: Message.photoFailedMessage)
                    
                    /// **GIF Message**
                    /// ``MessageStyle/media(_:)``, ``MediaType/gif(_:)``
                    MessageRow(message: Message.giphyMessage)
                }
            }
            .previewDisplayName("Message Style")
            
            MessageItemMenuPreview()
                .previewDisplayName("Message Menu")
        }
        .environmentObject(ChatConfiguration(
            userID: User.user1.id,
            giphyKey: "wj5tEh9nAwNHVF3ZFavQ0zoaIyt8HZto"
        ))
        .padding(12)
    }
        
    struct MessageItemMenuPreview: View {
        @State private var isMessageMenuPresented: Bool = false
        var body: some View {
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
                MessageRow(message: Message.message2)
            }
        }
    }
}
