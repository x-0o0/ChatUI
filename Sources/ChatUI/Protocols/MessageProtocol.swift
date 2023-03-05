//
//  MessageProtocol.swift
//  
//
//  Created by Jaesung Lee on 2023/02/08.
//

import Foundation

/// A protocol that defines the necessary information for displaying a message regarding UI.
public protocol MessageProtocol: Hashable {
    /// The associated type that conforms to ``UserProtocol``
    associatedtype UserType: UserProtocol
    
    var id: String { get }
    var sender: UserType { get }
    var sentAt: Double { get }
    var editedAt: Double? { get }
    var readReceipt: ReadReceipt { get }
    var style: MessageStyle { get }
}

/// The protocol to support message reaction features.
/// - IMPORTANT: Currently, it supports single reaction item only that is type of `String`. It's recommeded that uses text emoji such as `"❤️"`, `"🙂"`, `"👍"` and so on.
public protocol MessageReactable: Hashable {
    /// The reaction status.
    /// - SeeAlso: ``ReactionStatus``
    var reaction: ReactionStatus { get set }
}

/// The enumeration for message reaction status.
/// - IMPORTANT: Currently, it supports single reaction item only that is type of `String`. It's recommeded that uses text emoji such as `"❤️"`, `"🙂"`, `"👍"` and so on.
public enum ReactionStatus: Equatable, Hashable {
    /// There is no reaction item in which the message has.
    case none
    /// There is a single reaction item on the message.
    case reacted(_ item: String)
}
