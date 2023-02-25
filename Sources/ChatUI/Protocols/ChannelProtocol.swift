//
//  ChannelProtocol.swift
//  
//
//  Created by Jaesung Lee on 2023/02/08.
//

import Foundation

/// A protocol that defines the necessary information for displaying a channel regarding UI.
public protocol ChannelProtocol {
    /// The associated type that conforms to ``UserProtocol``
    associatedtype UserType: UserProtocol
    /// The associated type that conforms to ``MessageProtocol``
    associatedtype MessageType: MessageProtocol
    
    var id: String { get }
    var name: String { get }
    var imageURL: URL? { get }
    var createdAt: Double { get }
    var members: [UserType] { get }
    var lastMessage: MessageType? { get }
}
