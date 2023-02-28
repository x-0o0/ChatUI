//
//  MessageList.swift
//  
//
//  Created by Jaesung Lee on 2023/02/08.
//

import SwiftUI

/**
 The view that lists message objects.
 
 In the intializer, you can list message objects that conform to ``MessageProtocol`` to display messages using the `rowContent` parameter.

 All the body and row contents are flipped vertically so that new messages can be listed from the bottom.

 The messages are listed in the following order, depending on the ``ReadReceipt`` value of the ``MessageProtocol``. For more details, please refer to ``MessageProtocol/readReceipt`` or ``ReadReceipt``.

 - **NOTE:** The order of the messages:  sending → failed → sent → delivered → seen
 */
public struct MessageList<MessageType: MessageProtocol & Identifiable, RowContent: View>: View {
    
    @EnvironmentObject var configuration: ChatConfiguration

    @Environment(\.appearance) var appearance
    
    @State private var isKeyboardShown = false
    @State private var scrollOffset: CGFloat = 0
    @State private var showsScrollButton: Bool = false
    
    /// The latest message goes very first.
    let showsDate: Bool
    let rowContent: (_ message: MessageType) -> RowContent
    let listName = "name.list.message"
    
    let sendingMessages: [MessageType]
    let failedMessages: [MessageType]
    let sentMessages: [MessageType]
    let deliveredMessages: [MessageType]
    let seenMessages: [MessageType]
    
    public var body: some View {
        ZStack(alignment: .bottom) {
            ScrollViewReader { scrollView in
                ScrollView {
                    GeometryReader { proxy in
                        let frame = proxy.frame(in: .named(listName))
                        let offset = frame.minY
                        Color.clear
                            .preference(
                                key: ScrollViewOffsetPreferenceKey.self,
                                value: offset
                            )
                    }
                    
                    LazyVStack(spacing: 0) {
                        ForEach(sendingMessages) { message in
                            rowContent(message)
                                .padding(.horizontal, 12)
                                .effect(.flipped)
                        }
                        
                        ForEach(failedMessages) { message in
                            rowContent(message)
                                .padding(.horizontal, 12)
                                .effect(.flipped)
                        }
                        
                        ForEach(sentMessages) { message in
                            rowContent(message)
                                .padding(.horizontal, 12)
                                .effect(.flipped)
                        }
                        
                        ForEach(deliveredMessages) { message in
                            rowContent(message)
                                .padding(.horizontal, 12)
                                .effect(.flipped)
                        }
                        
                        ForEach(seenMessages) { message in
                            VStack(spacing: 0) {
                                rowContent(message)
                                
                                if message.id == seenMessages.first?.id, message.sender.id == configuration.userID {
                                    HStack {
                                        Spacer()
                                        
                                        Text("seen")
                                            .font(appearance.footnote)
                                            .foregroundColor(appearance.secondary)
                                    }
                                    .padding(.trailing, 21)
                                }
                            }
                            .padding(.horizontal, 12)
                            .effect(.flipped)
                        }
                    }
                }
                .keyboard(isKeyboardShown ? .visible : .hidden)
                .onReceive(keyboardNotificationPublisher) { isShown in
                    isKeyboardShown = isShown
                }
                .coordinateSpace(name: listName)
                .onPreferenceChange(ScrollViewOffsetPreferenceKey.self) { value in
                    DispatchQueue.main.async { [self] in
                        let offsetValue = value ?? 0
                        let diff = offsetValue - scrollOffset
                        scrollOffset = offsetValue
                        
                        let isScrollButtonShown = offsetValue < -20
                        if showsScrollButton != isScrollButtonShown {
                            showsScrollButton = isScrollButtonShown
                        }
                        
                        if isKeyboardShown && diff < -20 {
                            isKeyboardShown = false
                        }
                    }
                }
                .effect(.flipped)
                /// When tapped sending button. Called after `onSent` in ``MessageField``
                .onChange(of: sendingMessages) { newValue in
                    if let id = sendingMessages.first?.id {
                        withAnimation {
                            scrollView.scrollTo(id, anchor: .bottom)
                        }
                    }
                }
                /// When tapped ``ScrollButton``
                .onReceive(scrollDownPublisher) { _ in
                    // Get the latest message ID
                    let id: String? = sendingMessages.first?.id
                    ?? failedMessages.first?.id
                    ?? sentMessages.first?.id
                    ?? deliveredMessages.first?.id
                    ?? seenMessages.first?.id
                    if let id = id {
                        withAnimation {
                            scrollView.scrollTo(id, anchor: .bottom)
                        }
                    }
                }
            }
            
            if showsScrollButton {
                ScrollButton()
                    .padding(.bottom, 8)
            }
        }
    }
    
    public init(
        _ messageData: [MessageType],
        showsDate: Bool = false, // TODO: Not Supported yet
        @ViewBuilder rowContent: @escaping (_ message: MessageType) -> RowContent
    ) {
        var sendingMessages: [MessageType] = []
        var failedMessages: [MessageType] = []
        var sentMessages: [MessageType] = []
        var deliveredMessages: [MessageType] = []
        var seenMessages: [MessageType] = []
        
        messageData.forEach {
            switch $0.readReceipt {
            case .sending:
                sendingMessages.append($0)
            case .failed:
                failedMessages.append($0)
            case .sent:
                sentMessages.append($0)
            case .delivered:
                deliveredMessages.append($0)
            case .seen, .played:
                seenMessages.append($0)
            }
        }
        
        self.sendingMessages = sendingMessages
        self.failedMessages = failedMessages
        self.sentMessages = sentMessages
        self.deliveredMessages = deliveredMessages
        self.seenMessages = seenMessages
        
        self.showsDate = showsDate
        self.rowContent = rowContent
    }
}
