//
//  KeyboardNotificationPublisher.swift
//  
//
//  Created by Jaesung Lee on 2023/02/28.
//

import UIKit
import Combine

/// The publisher that sends the current visibilty of the keyboard.
///
/// - When `UIResponder.keyboardWillShowNotification` notification is called, it sends `true`.
/// - When `UIResponder.keyboardWillHideNotification` notification is called, it sends `false`.
///
/// Example Usage:
/// ```swift
/// .onReceive(keyboardNotificationPublisher) { isShown in
///     isKeyboardShown = isShown
/// }
/// ```
public var keyboardNotificationPublisher: AnyPublisher<Bool, Never> {
    Publishers
        .Merge(
            NotificationCenter
                .default
                .publisher(for: UIResponder.keyboardWillShowNotification)
                .map { _ in true },
            NotificationCenter
                .default
                .publisher(for: UIResponder.keyboardWillHideNotification)
                .map { _ in false }
        )
        .debounce(for: .seconds(0.1), scheduler: RunLoop.main)
        .eraseToAnyPublisher()
}
