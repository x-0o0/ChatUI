//
//  MessageRow.swift
//  
//
//  Created by Jaesung Lee on 2023/02/08.
//

import SwiftUI

public struct MessageRow<M: MessageProtocol>: View {
    
    @EnvironmentObject var configuration: ChatConfiguration
    @Environment(\.appearance) var appearance
    
    let message: M
    let showsUsername: Bool
    let showsDate: Bool
    let showsProfileImage: Bool
    let showsReadReceiptStatus: Bool
    
    var isMyMessage: Bool {
        message.sender.id == configuration.userID
    }
    
    public var body: some View {
        VStack(spacing: 0) {
            HStack(alignment: .bottom, spacing: 4) {
                if isMyMessage {
                    Spacer()
                    
                    if showsDate {
                        Text(
                            Date(timeIntervalSince1970: message.sentAt),
                            formatter: formatter
                        )
                        .messageStyle(.date)
                    }
                } else {
                    if showsProfileImage {
                        AsyncImage(url: message.sender.imageURL) { image in
                            image
                                .resizable()
                                .messageStyle(.senderProfile)
                        } placeholder: {
                            Image(systemName: "person.crop.circle.fill")
                                .resizable()
                                .messageStyle(.senderProfile)
                                .foregroundColor(appearance.secondary)
                        }
                    }
                }
                
                VStack(alignment: isMyMessage ? .trailing : .leading, spacing: 2) {
                    if showsUsername, !isMyMessage {
                        Text(message.sender.username)
                            .messageStyle(.senderName)
                            .padding(.horizontal, 8)
                    }
                    
                    switch message.style {
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
                
                if !isMyMessage {
                    if showsDate {
                        Text(
                            Date(timeIntervalSince1970: message.sentAt),
                            formatter: formatter
                        )
                        .messageStyle(.date)
                    }
                    
                    Spacer()
                }
            }
            
            if showsReadReceiptStatus, isMyMessage {
                HStack {
                    Spacer()
                    
                    switch message.readReceipt {
                    case .sending:
                        Image.sending.xSmall2
                            .clipShape(Circle())
                            .foregroundColor(appearance.secondary)
                            .padding(.top, 4)
                    case .failed:
                        Image.failed.xSmall2
                            .clipShape(Circle())
                            .foregroundColor(appearance.error)
                            .padding(.top, 4)
                    case .sent:
                        Image.sent.xSmall2
                            .clipShape(Circle())
                            .foregroundColor(appearance.tint)
                            .padding(.top, 4)
                    case .delivered:
                        Image.delivered.xSmall2
                            .clipShape(Circle())
                            .foregroundColor(appearance.tint)
                            .padding(.top, 4)
                    default:
                        EmptyView()
                    }
                }
                
            }
        }
    }
    
    public init(
        message: M,
        showsUsername: Bool = true,
        showsDate: Bool = true,
        showsProfileImage: Bool = true,
        showsReadReceiptStatus: Bool = true
    ) {
        self.message = message
        self.showsUsername = showsUsername
        self.showsDate = showsDate
        self.showsProfileImage = showsProfileImage
        self.showsReadReceiptStatus = showsReadReceiptStatus
    }
    
    var formatter: DateFormatter {
        let formatter = DateFormatter()
        formatter.dateFormat = "hh:mm"
        return formatter
    }
}
