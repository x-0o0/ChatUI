//
//  ScrollViewOffsetPreferenceKey.swift
//  
//
//  Created by Jaesung Lee on 2023/02/08.
//

import SwiftUI

/// The preference key to detect scroll view offeset
public struct ScrollViewOffsetPreferenceKey: PreferenceKey {
    public internal(set) static var defaultValue: CGFloat? = nil

    public static func reduce(value: inout CGFloat?, nextValue: () -> CGFloat?) {
        value = value ?? nextValue()
    }
}
