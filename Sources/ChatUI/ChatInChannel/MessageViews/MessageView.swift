//
//  MessageView.swift
//  
//
//  Created by Jaesung Lee on 2023/03/05.
//

import SwiftUI

struct MessageView: View {
    @Environment(\.appearance) var appearance
    
    let style: MessageStyle
    let isMyMessage: Bool
    
    var body: some View {
        switch style {
        case .text(let text):
            let markdown = LocalizedStringKey(text)
            Text(markdown)
                .tint(isMyMessage ? appearance.prominentLink : appearance.link)
                .messageStyle(isMyMessage ? .localBody : .remoteBody)
        case .media(let mediaType):
            switch mediaType {
            case .emoji(let key):
                Text(key)
                    .messageStyle(isMyMessage ? .localBody : .remoteBody)
            case .gif(let key):
                GiphyStyleView(id: key)
            case .photo(let data):
                PhotoStyleView(data: data)
            case .video(let data):
                Text("\(data)")
                    .lineLimit(5)
                    .messageStyle(isMyMessage ? .localBody : .remoteBody)
            case .document(let data):
                Text("\(data)")
                    .lineLimit(5)
                    .messageStyle(isMyMessage ? .localBody : .remoteBody)
            case .contact(let contact):
                let markdown = """
            Name: **\(contact.givenName) \(contact.familyName)**
            Phone: \(contact.phoneNumbers)
            """
                Text(.init(markdown))
                    .messageStyle(isMyMessage ? .localBody : .remoteBody)
            case .location(let latitude, let longitude):
                LocationStyleView(
                    latitude: latitude,
                    longitude: longitude
                )
            }
        case .voice(let data):
            VoiceStyleView(data: data)
                .messageStyle(isMyMessage ? .localBody : .remoteBody)
        }
    }
}
