//
//  UserProtocol.swift
//  
//
//  Created by Jaesung Lee on 2023/02/08.
//

import Foundation

/// A protocol that defines the necessary information for displaying a user regarding UI.
public protocol UserProtocol: Identifiable, Hashable {
    var id: String { get }
    var username: String { get }
    var imageURL: URL? { get }
}
