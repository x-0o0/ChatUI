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
    let lineLimit: Int?
    
    var body: some View {
        switch style {
        case .text(let text):
            let markdown = LocalizedStringKey(text)
            Text(markdown)
                .tint(isMyMessage ? appearance.prominentLink : appearance.link)
                .messageStyle(isMyMessage ? .localBody(lineLimit) : .remoteBody(lineLimit))
        case .media(let mediaType):
            switch mediaType {
            case .emoji(let key):
                Text(key)
                    .messageStyle(isMyMessage ? .localBody(lineLimit) : .remoteBody(lineLimit))
            case .gif(let key):
                GiphyStyleView(id: key)
            case .photo(let data):
                PhotoStyleView(data: data)
            case .video(let data):
                Text("\(data)")
                    .lineLimit(5)
                    .messageStyle(isMyMessage ? .localBody(lineLimit) : .remoteBody(lineLimit))
            case .document(let data):
                Text("\(data)")
                    .lineLimit(5)
                    .messageStyle(isMyMessage ? .localBody(lineLimit) : .remoteBody(lineLimit))
            case .contact(let contact):
                let markdown = """
            Name: **\(contact.givenName) \(contact.familyName)**
            Phone: \(contact.phoneNumbers)
            """
                Text(.init(markdown))
                    .messageStyle(isMyMessage ? .localBody(lineLimit) : .remoteBody(lineLimit))
            case .location(let latitude, let longitude):
                LocationStyleView(
                    latitude: latitude,
                    longitude: longitude
                )
            }
        case .voice(let data):
            VoiceStyleView(data: data)
                .messageStyle(isMyMessage ? .localBody(lineLimit) : .remoteBody(lineLimit))
        }
    }
}
