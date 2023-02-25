//
//  ChannelStack.swift
//  
//
//  Created by Jaesung Lee on 2023/02/09.
//

import SwiftUI

// TODO: VStack 감싸기
/**
 ```swift
 ChannelStack(channel, spacing: 0) {
    MessageList() { ... }
 
    MessageField { ... }
 }
 .channelInfoBar { ... }
 ```
 */

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
public struct ChannelStack<C: ChannelProtocol, Content: View>: View {
    @EnvironmentObject private var configuration: ChatConfiguration
    
    let channel: C
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
        _ channel: C,
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
