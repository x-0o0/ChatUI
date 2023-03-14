//
//  MessageList.swift
//  
//
//  Created by Jaesung Lee on 2023/02/08.
//

import SwiftUI
import Combine

/**
 The view that lists message objects.
 
 In the intializer, you can list message objects that conform to ``MessageProtocol`` to display messages using the `rowContent` parameter.

 All the body and row contents are flipped vertically so that new messages can be listed from the bottom.

 The messages are listed in the following order, depending on the ``ReadReceipt`` value of the ``MessageProtocol``. For more details, please refer to ``MessageProtocol/readReceipt`` or ``ReadReceipt``.

 - **NOTE:** The order of the messages:  sending → failed → sent → delivered → seen
 */
public struct MessageList<MessageType: MessageProtocol & Identifiable, RowContent: View, MenuContent: View>: View {
    
    @EnvironmentObject var configuration: ChatConfiguration

    @Environment(\.appearance) var appearance
    
    @State private var isKeyboardShown = false
    @State private var scrollOffset: CGFloat = 0
    @State private var showsScrollButton: Bool = false
    @State private var highlightMessage: MessageType? = nil
    @State private var isMessageMenuPresented: Bool = false
    
    /// The latest message goes very first.
    let showsDate: Bool
    let rowContent: (_ message: MessageType) -> RowContent
    let listName = "name.list.message"
    
    let messageMenuContent: ((_ message: MessageType) -> MenuContent)?
    let reactionItems: [String]
    
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
                        sendingMessageList
                        
                        failedMessageList
                        
                        sentMessageList
                        
                        deliveredMessageList
                        
                        seenMessageList
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
        .overlay {
            // MARK: blur
            if highlightMessage != nil {
                Rectangle()
                    .fill(.ultraThinMaterial)
                    .ignoresSafeArea()
                    .onTapGesture {
                        isMessageMenuPresented = false
                        highlightMessagePublisher.send(nil)
                    }
            }
        }
        .overlayPreferenceValue(BoundsPreferenceKey.self) { values in
            // MARK: Detects which message row is tapped
            if let highlightMessage = highlightMessage, let preference = values.first(where: { item in
                item.key == highlightMessage.id
            }) {
                GeometryReader { proxy in
                    let rect = proxy[preference.value]
                    // presenting view as an overlay, so that it will look like custom context
                    VStack(alignment: configuration.userID == highlightMessage.sender.id ? .trailing : .leading, spacing: 0) {
                        // MARK: Message Reaction
                        if highlightMessage.readReceipt == .seen, !reactionItems.isEmpty {
                            ReactionSelector(isPresented: $isMessageMenuPresented, message: highlightMessage, items: reactionItems) { reactionItem in
                                // MARK: Close Highlight
                                withAnimation(.easeInOut) {
                                    isMessageMenuPresented = false
                                    self.highlightMessage = nil
                                }
                                
                                // Reaction Publisher
                                withAnimation(.easeInOut.delay(0.3)) {
                                    let _ = Empty<Void, Never>()
                                        .sink { _ in
                                            messageReactionPublisher.send((reactionItem, highlightMessage.id))
                                        } receiveValue: { _ in }
                                }
                            }
                            .padding(.top, rect.minY > 0 ? rect.minY - 36.5 : 0)
                        } else {
                            Spacer()
                                .frame(maxHeight: rect.minY > 0 ? rect.minY : 0)
                        }
                        
                        // MARK: Message Row
                        rowContent(highlightMessage)
                            .frame(width: rect.width, height: rect.height)
                        
                        // MARK: Message Menu
                        if let messageMenuContent = messageMenuContent {
                            messageMenuContent(highlightMessage)
                        }
                        
                        Spacer()
                    }
                    .id(highlightMessage.id)
                    .offset(x: rect.minX)
                }
                .transition(.asymmetric(insertion: .identity, removal: .offset(x: 1)))
            }
        }
        .onReceive(highlightMessagePublisher) { highlightMessage in
            if let highlightMessage = highlightMessage as? MessageType {
                self.highlightMessage = highlightMessage
                withAnimation(.easeInOut) {
                    self.isMessageMenuPresented = true
                }
            } else {
                self.highlightMessage = nil
                withAnimation(.easeInOut) {
                    self.isMessageMenuPresented = false
                }

            }
            
        }
    }
    
    /// The view that lists `messageData` which is an array of the objects that conform to ``MessageProtocol``
    ///
    /// - Parameters:
    ///    - messageData: The array of objects that conform to ``MessageProtocol``
    ///    - showsDate: The boolean value that indicates whether shows date or not.
    ///    - reactionItems: The array of reaction item that is type of `String`. e.g., `["❤️", "👍", "👎", "😆", "🎉"]`
    ///    - rowContent: The row content for the message list. Each row represent one `message`. It's recommended that uses ``MessageRow``.
    ///    - menuContent: The menu content for `message`. It's recommended that uses ``MessageMenu`` and ``MessageMenuButtonStyle``
    ///
    /// Example usage:
    /// ```swift
    /// MessageList(messages, reactionItems: ["❤️", "👍", "👎", "😆", "🎉"]) { message in
    ///     MessageRow(message: message)
    /// } menuContent: { highlightMessage in
    ///     MessageMenu {
    ///         Button(action: copy) {
    ///             HStack {
    ///                 Text("Copy")
    ///
    ///                 Spacer()
    ///
    ///                 Image(systemName: "doc.on.doc")
    ///             }
    ///             .padding(.horizontal, 16)
    ///             .foregroundColor(appearance.primary)
    ///         }
    ///         .frame(height: 44)
    ///
    ///         Divider()
    ///
    ///         Button(action: delte) {
    ///             .HStack {
    ///                 Text("Delete")
    ///
    ///                 Spacer()
    ///
    ///                 Image(systemName: "trash")
    ///             }
    ///             .padding(.horizontal, 16)
    ///             .foregroundColor(appearance.primary)
    ///         }
    ///         .frame(height: 44)
    ///     }
    ///     .padding(.top, 12)
    /// }
    /// .onReceive(messageReactionPublisher) { (reactionItem, messageID) in
    ///     // handle message with reactionItem
    /// }
    /// ```
    public init(
        _ messageData: [MessageType],
        showsDate: Bool = false, // TODO: Not Supported yet
        reactionItems: [String] = [],
        @ViewBuilder rowContent: @escaping (_ message: MessageType) -> RowContent,
        @ViewBuilder menuContent: @escaping (_ message: MessageType) -> MenuContent
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
        self.reactionItems = reactionItems
        self.messageMenuContent = menuContent
    }
    
    /// The view that lists `messageData` which is an array of the objects that conform to ``MessageProtocol``
    ///
    /// - Parameters:
    ///    - messageData: The array of objects that conform to ``MessageProtocol``
    ///    - showsDate: The boolean value that indicates whether shows date or not.
    ///    - reactionItems: The array of reaction item that is type of `String`. e.g., `["❤️", "👍", "👎", "😆", "🎉"]`
    ///    - rowContent: The row content for the message list. Each row represent one `message`. It's recommended that uses ``MessageRow``.
    ///
    /// Example usage:
    /// ```swift
    /// MessageList(messages, reactionItems: ["❤️", "👍", "👎", "😆", "🎉"]) { message in
    ///     MessageRow(message: message)
    /// }
    /// .onReceive(messageReactionPublisher) { (reactionItem, messageID) in
    ///     // handle message with reactionItem
    /// }
    /// ```
    public init(
        _ messageData: [MessageType],
        showsDate: Bool = false, // TODO: Not Supported yet
        reactionItems: [String] = [],
        @ViewBuilder rowContent: @escaping (_ message: MessageType) -> RowContent
    ) where MenuContent == EmptyView {
        self.init(
            messageData,
            showsDate: showsDate,
            reactionItems: reactionItems,
            rowContent: rowContent
        ) { _ in
            EmptyView()
        }
    }
    
    var sendingMessageList: some View {
        ForEach(sendingMessages) { message in
            VStack(spacing: 0) {
                if showsDate(for: message) {
                    MessageDateView(message: message)
                }
                
                rowContent(message)
                    .anchorPreference(key: BoundsPreferenceKey.self, value: .bounds) { anchor in
                        [message.id: anchor]
                    }
            }
            .padding(.horizontal, 12)
            .effect(.flipped)
        }
    }
    
    var failedMessageList: some View {
        ForEach(failedMessages) { message in
            rowContent(message)
                .anchorPreference(key: BoundsPreferenceKey.self, value: .bounds) { anchor in
                    [message.id: anchor]
                }
                .padding(.horizontal, 12)
                .effect(.flipped)
        }
    }
    
    var sentMessageList: some View {
        ForEach(sentMessages) { message in
            VStack(spacing: 0) {
                if showsDate(for: message) {
                    MessageDateView(message: message)
                }
                
                rowContent(message)
                    .anchorPreference(key: BoundsPreferenceKey.self, value: .bounds) { anchor in
                        [message.id: anchor]
                    }
            }
            .padding(.horizontal, 12)
            .effect(.flipped)
        }
    }
    
    var deliveredMessageList: some View {
        ForEach(deliveredMessages) { message in
            VStack(spacing: 0) {
                if showsDate(for: message) {
                    MessageDateView(message: message)
                }
                
                rowContent(message)
                    .anchorPreference(key: BoundsPreferenceKey.self, value: .bounds) { anchor in
                        [message.id: anchor]
                    }
            }
            .padding(.horizontal, 12)
            .effect(.flipped)
        }
    }
    
    var seenMessageList: some View {
        ForEach(seenMessages) { message in
            VStack(spacing: 0) {
                if showsDate(for: message) {
                    MessageDateView(message: message)
                }
                
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
            }
            .anchorPreference(key: BoundsPreferenceKey.self, value: .bounds) { anchor in
                [message.id: anchor]
            }
            .padding(.horizontal, 12)
            .effect(.flipped)
        }
    }
}
