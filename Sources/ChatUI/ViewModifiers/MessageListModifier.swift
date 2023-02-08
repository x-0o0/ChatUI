//
//  MessageListModifier.swift
//  
//
//  Created by Jaesung Lee on 2023/02/08.
//

import SwiftUI

public class EffectModifier {
    public enum Style {
        /// To Flip the view. It rotates the view and scales this view’s rendered output by horizontal amont -1.
        case flipped
    }
    
    /// The effect that flips the view. It rotates the view and scales this view’s rendered output by horizontal amont -1.
    public struct FlippedEffect: ViewModifier {
        public func body(content: Content) -> some View {
            content
                .rotationEffect(.radians(Double.pi))
                .scaleEffect(x: -1, y: 1, anchor: .center)
        }
    }
}

extension View {
    /**
     Applies the effect such as *flipping*
     
     ``MessageList`` applies this effect as ``EffectModifier/Style/flipped`` and also the ``EffectModifier/Style/flipped`` is applied to the `rowContent` of the ``MessageList``
     
     **Example usage:**
     
     ```swift
     MessageRow(message: message)
         .effect(.flipped)
     ```
     */
    public func effect(_ style: EffectModifier.Style) -> some View {
        switch style {
        case .flipped:
            return AnyView(modifier(EffectModifier.FlippedEffect()))
        }
    }
}
