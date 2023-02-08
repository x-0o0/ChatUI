//
//  MessageModifier.swift
//  
//
//  Created by Jaesung Lee on 2023/02/08.
//

import SwiftUI

public class MessageModifier {
    public enum Style {
        case remoteBody
        case localBody
        case date
        case receipt
        case senderName
        case senderProfile
    }
    
    public static var remoteBodyStyle = RemoteBody()
    
    public static var localBodyStyle = LocalBody()
    
    public static var dateStyle = Date()
    
    public static var receiptStyle = Receipt()
    
    public static var senderName = SenderName()
    
    public static var senderProfile = SenderProfile()
    
    public struct RemoteBody: ViewModifier {
        @Environment(\.appearance) var appearance
        
        public func body(content: Content) -> some View {
            content
                .lineLimit(10)
                .font(appearance.messageBody)
                .frame(minWidth: 18) /// To make the bubble to be a circle shape, when the text is too short
                .padding(12)
                .foregroundColor(appearance.primary)
                .background(appearance.remoteMessageBackground)
                .clipShape(RoundedRectangle(cornerRadius: 21))
        }
    }
    
    public struct LocalBody: ViewModifier {
        @Environment(\.appearance) var appearance
        
        public func body(content: Content) -> some View {
            content
                .lineLimit(10)
                .font(appearance.messageBody)
                .frame(minWidth: 18) /// To make the bubble to be a circle shape, when the text is too short
                .padding(12)
                .foregroundColor(appearance.background)
                .background(appearance.localMessageBackground)
                .clipShape(RoundedRectangle(cornerRadius: 21))
        }
    }
    
    public struct Date: ViewModifier {
        @Environment(\.appearance) var appearance
        
        public func body(content: Content) -> some View {
            content
                .font(appearance.caption)
                .foregroundColor(appearance.secondary)
        }
    }
    
    public struct Receipt: ViewModifier {
        
        public func body(content: Content) -> some View {
            content
                .font(.largeTitle)
        }
    }
    
    public struct SenderName: ViewModifier {
        @Environment(\.appearance) var appearance
        
        public func body(content: Content) -> some View {
            content
                .font(appearance.footnote)
                .foregroundColor(appearance.secondary)
        }
    }
    
    public struct SenderProfile: ViewModifier {
        @Environment(\.appearance) var appearance
        
        public func body(content: Content) -> some View {
            content
                .frame(width: 24, height: 24)
                .aspectRatio(contentMode: .fill)
                .clipShape(Circle())
                .padding(1)
                .background {
                    appearance.imagePlaceholder
                        .clipShape(Circle())
                }
        }
    }
}

extension View {
    public func messageStyle(_ style: MessageModifier.Style) -> some View {
        switch style {
        case .remoteBody:
            return AnyView(modifier(MessageModifier.remoteBodyStyle))
        case .localBody:
            return AnyView(modifier(MessageModifier.localBodyStyle))
        case .date:
            return AnyView(modifier(MessageModifier.dateStyle))
        case .receipt:
            return AnyView(modifier(MessageModifier.receiptStyle))
        case .senderName:
            return AnyView(modifier(MessageModifier.senderName))
        case .senderProfile:
            return AnyView(modifier(MessageModifier.senderProfile))
        }
    }
}


