//
//  ScrollButton.swift
//  
//
//  Created by Jaesung Lee on 2023/02/09.
//

import SwiftUI
import Combine

public struct ScrollButton: View {
    @Environment(\.appearance) var appearance
    
    public var body: some View {
        Button(action: scrollToBotton) {
            Image.directionDown.small
                .foregroundColor(appearance.tint)
                .padding(8)
                .background {
                    Color(.systemBackground)
                        .clipShape(Circle())
                        .shadow(radius: 6)
                }
        }
    }
    
    func scrollToBotton() {
        let _ = Empty<Void, Never>()
            .sink(
                receiveCompletion: { _ in
                    print("☺️ scrollsToBottom send")
                    scrollDownPublisher.send(())
                },
                receiveValue: { _ in }
            )
    }
}
