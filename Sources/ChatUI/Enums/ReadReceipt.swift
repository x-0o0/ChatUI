//
//  ReadReceipt.swift
//  
//
//  Created by Jaesung Lee on 2023/02/08.
//

import Foundation

/// The enumeration that represents the read receipt status of the message.
public enum ReadReceipt: Int, Codable, Hashable {
    /// The message is sending
    case sending
    /// The message was failed sending
    case failed
    /// The message was successfully sent.
    case sent
    /// The message has been delivered to your recipient's phone or linked devices, but the recipient hasn’t seen it.
    case delivered
    /// The recipient has read your message.
    /// - The recipient has read your message or seen your picture, audio file, or video
    /// - The recipient has seen your voice message, but hasn’t played it.
    case seen
    /// The recipient has played your voice message.
    case played
}
