//
//  KeyboardReaderModifier.swift
//  
//
//  Created by Jaesung Lee on 2023/02/08.
//

import SwiftUI

public class KeyboardReaderModifier {
    public enum Interaction {
        case hideKeyboardByTapping(_ shouldAdd: Bool)
    }
    
    public struct HideKeyboardGesture: ViewModifier {
        var shouldAdd: Bool
        var onTapped: (() -> Void)?

        public init(shouldAdd: Bool, onTapped: (() -> Void)? = nil) {
            self.shouldAdd = shouldAdd
            self.onTapped = onTapped
        }

        public func body(content: Content) -> some View {
            content
                .gesture(
                    shouldAdd
                    ? TapGesture().onEnded { _ in
                        UIApplication.shared
                            .sendAction(
                                #selector(UIResponder.resignFirstResponder),
                                to: nil,
                                from: nil,
                                for: nil
                            )
                        
                        onTapped?()
                    }
                    : nil
                )
        }
    }

}

extension View {
    public func keyboardReader(_ interaction: KeyboardReaderModifier.Interaction) -> some View {
        switch interaction {
        case .hideKeyboardByTapping(let shouldAdd):
            return AnyView(modifier(KeyboardReaderModifier.HideKeyboardGesture(shouldAdd: shouldAdd)))
        }
    }
}
