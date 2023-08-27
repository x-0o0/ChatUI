//
//  MessageRow.swift
//
//
//  Created by Jaesung Lee on 2023/02/08.
//

import SwiftUI
import Combine

public struct MessageRow<M: MessageProtocol>: View {
    
    @EnvironmentObject var configuration: ChatConfiguration
    @Environment(\.colorScheme) var colorScheme
    @Environment(\.appearance) var appearance
    
    let message: M
    let showsUsername: Bool
    let showsDate: Bool
    let showsProfileImage: Bool
    let showsReadReceiptStatus: Bool
    let lineLimit: Int?
    
    @State private var isSelected: Bool = false
    
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
                    
                    if let reactableMessage = message as? (any MessageReactable) {
                        switch reactableMessage.reaction {
                        case .none:
                            EmptyView()
                        case .reacted(let reactionItem):
                            ReactionEffectView(
                                item: reactionItem,
                                effectTint: isMyMessage
                                ? appearance.remoteMessageBackground
                                : appearance.localMessageBackground
                            )
                            .offset(x: isMyMessage ? 15 : -15)
                            .padding(.bottom, -25)
                            .zIndex(1)
                            .opacity(isSelected ? 0 : 1)
                        }
                        
                    }
                    
                    // MARK: Message bubble
                    MessageView(style: message.style, isMyMessage: isMyMessage, lineLimit: lineLimit)
                        .zIndex(0)
                        .onTapGesture { }
                        .onLongPressGesture {
                            withAnimation(.easeInOut) {
                                let _ = Empty<Void, Never>()
                                    .sink { _ in
                                        highlightMessagePublisher.send(message)
                                    } receiveValue: { _ in }
                            }
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
                        appearance.images.sending(colorScheme).xSmall2
                            .clipShape(Circle())
                            .foregroundColor(appearance.secondary)
                            .padding(.top, 4)
                    
                    case .failed:
                        appearance.images.failed(colorScheme).xSmall2
                            .clipShape(Circle())
                            .foregroundColor(appearance.error)
                            .padding(.top, 4)

                    case .sent:
                        appearance.images.sent(colorScheme).xSmall2
                            .clipShape(Circle())
                            .foregroundColor(appearance.tint)
                            .padding(.top, 4)
                    
                    case .delivered:
                        appearance.images.delivered(colorScheme).xSmall2
                            .clipShape(Circle())
                            .foregroundColor(appearance.tint)
                            .padding(.top, 4)
                            
                    default:
                        EmptyView()
                    }
                }
                
            }
        }
        .onReceive(highlightMessagePublisher) { highlightMessage in
            isSelected = message.id == highlightMessage?.id
        }
    }
    
    public init(
        message: M,
        showsUsername: Bool = true,
        showsDate: Bool = true,
        showsProfileImage: Bool = true,
        showsReadReceiptStatus: Bool = true,
        lineLimit: Int? = nil
    ) {
        self.message = message
        self.showsUsername = showsUsername
        self.showsDate = showsDate
        self.showsProfileImage = showsProfileImage
        self.showsReadReceiptStatus = showsReadReceiptStatus
        self.lineLimit = lineLimit
    }
    
    var formatter: DateFormatter {
        let formatter = DateFormatter()
        formatter.dateFormat = appearance.messageTimeFormat
        return formatter
    }
}
