//
//  ReactionSelector.swift
//  
//
//  Created by Jaesung Lee on 2023/03/05.
//

import SwiftUI

public struct ReactionSelector<MessageType: MessageProtocol>: View {
    @Environment(\.appearance) var appearance
    
    @Binding var isPresented: Bool
    
    let message: MessageType
    let items: [String]
    let onReaction: (String) -> ()
    
    
    // update the count based on your reaction item array size
    @State var effectItem: [Bool] = Array(repeating: false, count: 5)
    @State var isEffectAnimated: Bool = false
    
    public var body: some View {
        HStack(spacing: 12) {
            ForEach(Array(items.enumerated()), id: \.element) { index, item in
                Text(item)
                    .font(appearance.title)
                    .scaleEffect(effectItem[index] ? 1 : 0.1)
                    .onAppear {
                        // animate
                        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                            withAnimation(.easeInOut.delay(Double(index) * 0.1)) {
                                effectItem[index] = true
                            }
                        }
                    }
                    .onTapGesture {
                        onReaction(items[index])
                    }
            }
        }
        .padding(.horizontal, 15)
        .padding(.vertical, 8)
        .background {
            Capsule()
                .fill(appearance.secondaryBackground)
                .mask {
                    Capsule()
                        .scaleEffect(isEffectAnimated ? 1 : 0.1, anchor: .leading)
                }
        }
        .onAppear {
            withAnimation {
                isEffectAnimated = true
            }
        }
        .onChange(of: isPresented) { newValue in
            if !newValue {
                withAnimation(.easeInOut(duration: 0.2).delay(0.15)) {
                    isEffectAnimated = true
                }
                
                for index in items.indices {
                    withAnimation(.easeInOut) {
                        effectItem[index] = false
                    }
                }
            }
        }
    }
    
    init(isPresented: Binding<Bool>, message: MessageType, items: [String], onReaction: @escaping (String) -> Void) {
        self._isPresented = isPresented
        self.message = message
        self.items = items
        self.onReaction = onReaction
        self.effectItem = effectItem
        self.isEffectAnimated = isEffectAnimated
    }
}
