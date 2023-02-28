//
//  KeyboardVisibilityPublisher.swift
//  
//
//  Created by Jaesung Lee on 2023/02/28.
//

import UIKit
import Combine

/**
 The publisher that publishes event with a boolean value that indicates whether it needs to show/hide keyboard.
 */
public var keyboardVisibilityPublisher = PassthroughSubject<Bool, Never>()
