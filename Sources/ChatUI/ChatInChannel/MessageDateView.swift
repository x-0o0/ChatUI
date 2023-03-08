//
//  MessageDateView.swift
//  
//
//  Created by Jaesung Lee on 2023/03/08.
//

import SwiftUI

/// The view that shows the messages year, month, day
public struct MessageDateView<MessageType: MessageProtocol>: View {
    @Environment(\.appearance) var appearance
    
    let date: Date
    
    public var body: some View {
        Text(date, style: .date)
            .font(.caption)
            .foregroundColor(appearance.secondary)
            .padding(.top, 12)
    }
    
    public init(message: MessageType) {
        self.date = Date(timeIntervalSince1970: message.sentAt / 1000)
    }
}

extension MessageList {
    /// - Returns: The boolean value whether the `message` is different from the previous message.
    func showsDate(for message: MessageType) -> Bool {
        guard self.showsDate else { return false }
        var index: Int?
        switch message.readReceipt {
        case .sending:
            index = sendingMessages.firstIndex { $0.id == message.id}
        case .failed:
            return false
        case .sent:
            index = sentMessages.firstIndex { $0.id == message.id}
        case .delivered:
            index = deliveredMessages.firstIndex { $0.id == message.id}
        case .seen, .played:
            index =  seenMessages.firstIndex { $0.id == message.id}
        }
        guard let index = index else { return true }
        
        var prevMessage: MessageType?
        switch message.readReceipt {
        case .sending:
            if index == sendingMessages.count - 1 {
                prevMessage = sentMessages.first
            } else {
                prevMessage = sendingMessages[index + 1]
            }
        case .failed:
            return false
        case .sent:
            if index == sentMessages.count - 1 {
                prevMessage = deliveredMessages.first
            } else {
                prevMessage = sentMessages[index + 1]
            }
        case .delivered:
            if index == deliveredMessages.count - 1 {
                prevMessage = seenMessages.first
            } else {
                prevMessage = deliveredMessages[index + 1]
            }
        case .seen, .played:
            guard index < seenMessages.count - 1 else { return true }
            prevMessage = seenMessages[index + 1]
        }
        guard let prevMessage = prevMessage else { return true }
        
        let curCreatedAt = message.sentAt
        let prevCreatedAt = prevMessage.sentAt
        
        return !(Date.from(prevCreatedAt).isSameDay(as: Date.from(curCreatedAt)))
    }
}

extension Date {
    static public func from(_ baseTimestamp: Double) -> Date {
        let timestampString = String(format: "%lld", baseTimestamp)
        let timeInterval = timestampString.count == 10
            ? TimeInterval(baseTimestamp)
            : TimeInterval(Double(baseTimestamp) / 1000.0)
        return Date(timeIntervalSince1970: timeInterval)
    }
    
    func isSameDay(as otherDate: Date) -> Bool {
        let baseDate = self
        let otherDate = otherDate
 
        let baseDateComponents = Calendar.current.dateComponents(
            [.day, .month, .year],
            from: baseDate
        )
        let otherDateComponents = Calendar.current.dateComponents(
            [.day, .month, .year],
            from: otherDate
        )

        if baseDateComponents.year == otherDateComponents.year,
            baseDateComponents.month == otherDateComponents.month,
            baseDateComponents.day == otherDateComponents.day {
            return true
        }
        else {
            return false
        }
    }
}
