//
//  KeyboardReaderModifier.swift
//  
//
//  Created by Jaesung Lee on 2023/02/08.
//

import SwiftUI
import Combine

public class KeyboardReaderModifier {
    public struct KeyboardVisibilityReader: ViewModifier {
        
        var hidesWhenTapped: Bool
        
        public init(hidesWhenTapped: Bool = true) {
            self.hidesWhenTapped = hidesWhenTapped
        }
        
        public func body(content: Content) -> some View {
            content
                .gesture(
                    TapGesture().onEnded { _ in
                        guard hidesWhenTapped else { return }
                        let _ = Empty<Void, Never>()
                            .sink(
                                receiveCompletion: { _ in
                                    keyboardVisibilityPublisher.send(false)
                                },
                                receiveValue: { _ in }
                            )
                    }
                )
                .onReceive(keyboardVisibilityPublisher) { isVisible in
                    switch isVisible {
                    case true:
                        UIApplication.shared
                            .sendAction(
                                #selector(UIResponder.becomeFirstResponder),
                                to: nil,
                                from: nil,
                                for: nil
                            )
                    case false:
                        UIApplication.shared
                            .sendAction(
                                #selector(UIResponder.resignFirstResponder),
                                to: nil,
                                from: nil,
                                for: nil
                            )
                    }
                }
        }
    }
    
}



/**
 ```swift
 @State var isKeyboardShown: Bool = false
 
 var body: some View {
    MessageList()
        .keyboardVisibility(isKeyboardShow ? .visible : .hidden)
        .onReceive(keyboardPublisher) { value in
            isKeyboardShown = value
        }
 }
 ```
 */


extension View {
    /**
     Update the visibility of the keyboard.
     
     - sends the `Visibility` value via `keyboardVisibilityPublisher` just one time to change the keyboard visibility state.
     - receives `keyboardVisibilityPublisher` events, use `keyboardReader()` modifier.

     - Parameter visibility: `Visibility` value. If it's `.visible`, ``keyboardVisibilityPublisher`` delivers `true`. If it's `.hidden`, ``keyboardVisibilityPublisher`` delivers `false`. If it's `.automatic`, it doesn't send any value via ``keyboardVisibilityPublisher``
     
     This examples shows a view that sends the `true` via `keyboardVisibility` publisher to shows keyboard and shows keyboard.
     
     ```swift
     SomeView()
        .keyboardVisibility(.visible) // Show up keyboard
     ```
     
     When you want to receive event only, not send, assign `.automatic` to the parameter(`visibility`).
     This examples shows a view that only receives `keyboardVisibilityPublisher` events.
     
     ```swift
     SomeView()
         .keyboardVisibility(.automatic)
     ```
     
     - NOTE: It's' recommended that use `onReceive(_:perform:)` together to receives `keyboardNotificationPublisher` event when use this method.
     ```swift
     @State var isKeyboardShown: Bool = false
          
     var body: some View {
         SomeView()
             .keyboardVisibility(isKeyboardShown ? .visible : .hidden)
             .onReceive(keyboardNotificationPublisher) { value in
                 isKeyboardShown = value
             }
         }
     }
     */
    public func keyboard(_ visibility: Visibility) -> some View {
        let _ = Empty<Void, Never>()
            .sink(
                receiveCompletion: { _ in
                    switch visibility {
                    case .automatic:
                        return
                    case .visible:
                        keyboardVisibilityPublisher.send(true)
                    case .hidden:
                        keyboardVisibilityPublisher.send(false)
                    }
                },
                receiveValue: { _ in }
            )
        return AnyView(
            modifier(
                KeyboardReaderModifier.KeyboardVisibilityReader()
            )
            
        )
    }
}
