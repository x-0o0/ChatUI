//
//  KeyboardReadable.swift
//  
//
//  Created by Jaesung Lee on 2023/02/08.
//

import Combine
import SwiftUI

/// The protoocl that defines the publisher to read the keyboard changes.
protocol KeyboardReadable {
    /// The publisher that reads the changes on the keyboard.
    var keyboardPublisher: AnyPublisher<Bool, Never> { get }
}

extension KeyboardReadable {
    var keyboardPublisher: AnyPublisher<Bool, Never> {
        Publishers.Merge(
            NotificationCenter.default
                .publisher(for: UIResponder.keyboardWillShowNotification)
                .map { _ in true },
            
            NotificationCenter.default
                .publisher(for: UIResponder.keyboardWillHideNotification)
                .map { _ in false }
        )
        .eraseToAnyPublisher()
    }
    
    /// The publisher that reads the height of the keyboard.
    public var keyboardHeight: AnyPublisher<CGFloat, Never> {
        NotificationCenter.default
            .publisher(for: UIResponder.keyboardDidShowNotification)
            .map {
                if let keyboardFrame: NSValue = $0
                    .userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue {
                    let keyboardRectangle = keyboardFrame.cgRectValue
                    let keyboardHeight = keyboardRectangle.height
                    return keyboardHeight
                } else {
                    return 0
                }
            }
            .eraseToAnyPublisher()
    }
}
