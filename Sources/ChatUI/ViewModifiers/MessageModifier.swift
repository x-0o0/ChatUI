//
//  MessageModifier.swift
//  
//
//  Created by Jaesung Lee on 2023/02/08.
//

import SwiftUI

public class MessageModifier {
    public enum Style {
        case remoteBody(_ lineLimit: Int?)
        case localBody(_ lineLimit: Int?)
        case date
        case receipt
        case senderName
        case senderProfile
    }
    
    public static func remoteBodyStyle(_ lineLimit: Int?) -> RemoteBody {
        RemoteBody(lineLimit: lineLimit)
    }
    
    public static func localBodyStyle(_ lineLimit: Int?) -> LocalBody {
        LocalBody(lineLimit: lineLimit)
    }
    
    public static var dateStyle = Date()
    
    public static var receiptStyle = Receipt()
    
    public static var senderName = SenderName()
    
    public static var senderProfile = SenderProfile()
    
    public struct RemoteBody: ViewModifier {
        @Environment(\.appearance) var appearance
        
        let lineLimit: Int?
        
        public func body(content: Content) -> some View {
            content
                .lineLimit(lineLimit)
                .font(appearance.body)
                .frame(minWidth: 18) /// To make the bubble to be a circle shape, when the text is too short
                .padding(12)
                .foregroundColor(appearance.primary)
                .background(appearance.remoteMessageBackground)
                .clipShape(RoundedRectangle(cornerRadius: 21))
        }
    }
    
    public struct LocalBody: ViewModifier {
        @Environment(\.appearance) var appearance
        
        let lineLimit: Int?
        
        public func body(content: Content) -> some View {
            content
                .lineLimit(lineLimit)
                .font(appearance.body)
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
        case .remoteBody(let lineLimit):
            return AnyView(modifier(MessageModifier.remoteBodyStyle(lineLimit)))
        case .localBody(let lineLimit):
            return AnyView(modifier(MessageModifier.localBodyStyle(lineLimit)))
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
