//
//  MessageOption.swift
//  
//
//  Created by Jaesung Lee on 2023/02/08.
//

import Foundation

/// The option for how to send message such as camera, mic and so on.
public enum MessageOption: Int, Hashable, CaseIterable {
    public static var all: [MessageOption] { MessageOption.allCases }
    case camera
    case photoLibrary
    case mic
    case giphy
    case location
    case menu
}
