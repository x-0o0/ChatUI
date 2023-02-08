//
//  SendMessagePublisher.swift
//  
//
//  Created by Jaesung Lee on 2023/02/11.
//

import Combine

/// The publisher that delivers ``MessageStyle``
/// ```swift
/// // How to publish
/// let _ = Empty<Void, Never>()
///    .sink(
///        receiveCompletion: { _ in
///            // Create `MessageStyle` object
///            let style = MessageStyle.text("{TEXT}")
///            sendMessagePublisher.send(style)
///        },
///        receiveValue: { _ in }
///    )
/// ```
/// ```swift
/// // How to subscribe
/// .onReceive(sendMessagePublisher) { messageStyle in
///     // Handle `messageStyle` here (e.g., sending message with the style)
/// }
/// ```
public var sendMessagePublisher = PassthroughSubject<MessageStyle, Never>()
