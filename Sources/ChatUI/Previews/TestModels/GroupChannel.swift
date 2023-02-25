//
//  GroupChannel.swift
//  
//
//  Created by Jaesung Lee on 2023/02/08.
//

import Foundation

struct GroupChannel: ChannelProtocol {
    var id: String
    var name: String
    var imageURL: URL?
    var members: [User]
    var createdAt: Double
    var lastMessage: Message?
}

extension GroupChannel {
    static let channel1 = GroupChannel(
        id: User.bluebottle.id,
        name: User.bluebottle.username,
        imageURL: User.bluebottle.imageURL,
        members: [User.user1, User.bluebottle],
        createdAt: 1675242048,
        lastMessage: nil
    )
    
    static let new = GroupChannel(
        id: UUID().uuidString,
        name: User.user2.username,
        imageURL: nil,
        members: [User.user1, User.user2],
        createdAt: 1675860481,
        lastMessage: Message.message1
    )
}
