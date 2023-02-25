//
//  Message.swift
//  
//
//  Created by Jaesung Lee on 2023/02/08.
//

import Foundation
import GiphyUISDK

struct Message: MessageProtocol, Identifiable {
    var id: String
    var sender: User
    var sentAt: Double
    var editedAt: Double?
    var readReceipt: ReadReceipt
    var style: MessageStyle
}

extension Message {
    static let message1 = Message(
        id: UUID().uuidString,
        sender: User.bluebottle,
        sentAt: 1675331868,
        readReceipt: .seen,
        style: .text("Hi, there! I would like to ask about my order [#1920543](https://instagram.com/j_sung_0o0). Your agent mentioned that it would be available on [September 18](mailto:). However, I haven’t been notified yet by your company about my product availability. Could you provide me some news regarding it?")
    )
    
    static let message2 = Message(
        id: UUID().uuidString,
        sender: User.user1,
        sentAt: 1675342668,
        readReceipt: .seen,
        style: .text("Hi **Alexander**, we’re sorry to hear that. Could you give us some time to check on your order first? We will update you as soon as possible. Thanks!")
    )
    
    static let message3 = Message(
        id: UUID().uuidString,
        sender: User.starbucks,
        sentAt: 1675342668,
        readReceipt: .delivered,
        style: .text("Hi **Daniel**,\nThanks for your booking. We’re pleased to have you on board with us soon. Please find your travel details attached.")
    )
    
    static let message4 = Message(
        id: UUID().uuidString,
        sender: User.bluebottle,
        sentAt: 1675334868,
        readReceipt: .seen,
        style: .text("Do you know what time is it?")
    )
    
    static let message5 = Message(
        id: UUID().uuidString,
        sender: User.bluebottle,
        sentAt: 1675338868,
        readReceipt: .seen,
        style: .text("What is the most popular meal in Japan?")
    )
    
    static let message6 = Message(
        id: UUID().uuidString,
        sender: User.user1,
        sentAt: 1675404869,
        readReceipt: .sent,
        style: .text("Do you know what time is it?\nRead receipt status: `.sent`")
    )
    
    static let message7 = Message(
        id: UUID().uuidString,
        sender: User.user1,
        sentAt: 1675408868,
        readReceipt: .delivered,
        style: .text("**What** is the most *popular* meal in [**Japan**](www.google.com)? ~~sushi~~\nRead receipt status: `.delivered`")
    )
    
    static let message8 = Message(
        id: UUID().uuidString,
        sender: User.user1,
        sentAt: 1675408868,
        readReceipt: .failed,
        style: .text("Read receipt status: `.failed`")
    )
    
    static let message9 = Message(
        id: UUID().uuidString,
        sender: User.user1,
        sentAt: 1675408868,
        readReceipt: .sending,
        style: .text("Read receipt status: `.sending`")
    )
    
    static let locationMessage = Message(
        id: UUID().uuidString,
        sender: User.user1,
        sentAt: 1675408868,
        readReceipt: .delivered,
        style: .media(.location(37.57827, 126.97695))
    )
    
    static let photoMessage: Message = {
        let data = (try? Data(contentsOf: URL(string: "https://picsum.photos/220")!)) ?? Data()
        return Message(
            id: UUID().uuidString,
            sender: User.user1,
            sentAt: 1675408868,
            readReceipt: .delivered,
            style: .media(.photo(data))
        )
    }()
    
    static let photoFailedMessage: Message = {
        let data = Data()
        return Message(
            id: UUID().uuidString,
            sender: User.user1,
            sentAt: 1675408868,
            readReceipt: .failed,
            style: .media(.photo(data))
        )
    }()
    
    static let giphyMessage: Message = {
        let id = "SU49goxca2V5XzxJPf"
        Giphy.configure(apiKey: "wj5tEh9nAwNHVF3ZFavQ0zoaIyt8HZto")
        return Message(
            id: UUID().uuidString,
            sender: User.user1,
            sentAt: 1675408868,
            readReceipt: .delivered,
            style: .media(.gif(id))
        )
    }()
}
