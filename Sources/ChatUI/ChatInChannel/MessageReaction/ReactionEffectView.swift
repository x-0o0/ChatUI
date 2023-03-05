//
//  ReactionEffectView.swift
//  
//
//  Created by Jaesung Lee on 2023/03/05.
//

import SwiftUI

// - INFORMATION: [Reference - Youtube](https://www.youtube.com/watch?v=S7hhHc9FgnY)
public struct ReactionEffectView: View {
    @Environment(\.appearance) var appearance
    
    @State var animationValues: [Bool] = Array(repeating: false, count: 6)
    
    var item: String
    var effectTint: Color
    
    public var body: some View {
        ZStack {
            Text(item)
                .font(appearance.title)
                .padding(6)
                .background {
                    effectTint
                        .clipShape(Circle())
                }
                .scaleEffect(animationValues[2] ? 1 : 0)
                .overlay {
                    Circle()
                        .stroke(effectTint, lineWidth: animationValues[1] ? 0 : 100)
                        .clipShape(Circle())
                        .scaleEffect(animationValues[0] ? 1.6 : 0.01)
                }
            // MARK: Random Circles
                .overlay {
                    ZStack {
                        ForEach(1...20, id: \.self) { index in
                            Circle()
                                .fill(effectTint)
                                .frame(width: .random(in: 3...5), height: .random(in: 3...5))
                                .offset(x: .random(in: -5...5), y: .random(in: -5...5))
                                .offset(x: animationValues[3] ? 45 : 10)
                                .rotationEffect(.init(degrees: Double(index) * 18.0))
                                .scaleEffect(animationValues[2] ? 1 : 0.01)
                                .opacity(animationValues[4] ? 0 : 1)
                        }
                    }
                }
        }
        .onAppear {
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                withAnimation(.easeInOut(duration: 0.35)) {
                    animationValues[0] = true
                }
                withAnimation(.easeInOut(duration: 0.45).delay(0.06)) {
                    animationValues[1] = true
                }
                withAnimation(.easeInOut(duration: 0.35).delay(0.3)) {
                    animationValues[2] = true
                }
                withAnimation(.easeInOut(duration: 0.35).delay(0.4)) {
                    animationValues[3] = true
                }
                withAnimation(.easeInOut(duration: 0.55).delay(0.55)) {
                    animationValues[4] = true
                }
            }
        }
    }
    
    public init(item: String, effectTint: Color) {
        self.item = item
        self.effectTint = effectTint
    }
}
