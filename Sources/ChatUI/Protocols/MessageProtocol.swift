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
