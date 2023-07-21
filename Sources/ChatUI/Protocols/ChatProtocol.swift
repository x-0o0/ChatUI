//
//  ChatProtocol.swift
//
//
//  Created by Fred Bowker on 2023/07/21.
//

/// defines the functionality that should be implemented when creating a chat service
public protocol ChatProtocol {
    associatedtype MessageType: MessageProtocol

    var messages: [MessageType] { get set }
    func sendMessage(style: MessageStyle)
}
