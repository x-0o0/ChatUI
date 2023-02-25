//
//  MessageItemPlacement.swift
//  
//
//  Created by Jaesung Lee on 2023/02/08.
//

import Foundation

// TODO: Not Support yet
/// The enumeration for the cases that how to aligns the messages.
enum MessageItemPlacement: Int, Hashable {
    /// Aligns all messages to the left side.
    case left
    /// Aligns all messages to the right side.
    case right
    /// Aligns messages to the both sides by following rules:
    /// - If the message is sent by the remote user, aligns to the left side.
    /// - If the message is sent by the local user, aligns to the right side.
    case both
}
