//
//  ChannelStack.swift
//  
//
//  Created by Jaesung Lee on 2023/02/09.
//

import SwiftUI

/**
 The *vertical* stack view that provides ``ChannelInfoView`` as a `ToolbarItem`.
 
 ```swift
 ChannelStack(channel) {
     MessageList(messages) {
        MessageRow(message)
     }
     
     MessageField(isMenuItemPresented: $isPresented) {
        sendMessage(style: $0)
     }
 }
 ```
 */
public struct ChannelStack<ChannelType: ChannelProtocol, Content: View>: View {
    @EnvironmentObject private var configuration: ChatConfiguration
    
    let channel: ChannelType
    let content: () -> Content
    
    public var body: some View {
        VStack(spacing: 0) {
            content()
        }
        .toolbar {
            ToolbarItem(placement: .navigationBarLeading) {
                ChannelInfoView(
                    imageURL: channel.imageURL,
                    title: channel.name,
                    subtitle: channel.id
                )
            }
        }
    }
    
    public init(
        _ channel: ChannelType,
        @ViewBuilder content: @escaping () -> Content
    ) {
        self.channel = channel
        self.content = content
    }
}

/**
 VStack {
    MessageList(..) { ... }
 
    MessageField { .. }
 }
 .channelInfoBar {
    
 }
 */
