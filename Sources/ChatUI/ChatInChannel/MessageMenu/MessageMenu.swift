//
//  MessageMenu.swift
//  
//
//  Created by Jaesung Lee on 2023/03/06.
//

import SwiftUI

/// The menu for the message
public struct MessageMenu<Content: View>: View {
    @Environment(\.appearance) var appearance
    @ViewBuilder let content: () -> Content
    
    public var body: some View {
        VStack(spacing: 0) {
            content()
        }
        .frame(width: 240)
        .background(appearance.remoteMessageBackground)
        .cornerRadius(14)
    }
    
    public init(@ViewBuilder content: @escaping () -> Content) {
        self.content = content
    }
}

public struct MessageMenuButtonStyle: ButtonStyle {
    @Environment(\.appearance) var appearance
    let symbol: String

    public func makeBody(configuration: Configuration) -> some View {
        HStack {
            configuration.label
            Spacer()
            Image(systemName: symbol)
        }
        .padding(.horizontal, 16)
        .foregroundColor(appearance.primary)
        .background(configuration.isPressed ? appearance.secondaryBackground : Color.clear)
        .frame(height: 44)
    }
    
    public init(symbol: String) {
        self.symbol = symbol
    }
}
