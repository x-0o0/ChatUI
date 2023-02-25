//
//  ScrollViewOffsetPreferenceKey.swift
//  
//
//  Created by Jaesung Lee on 2023/02/08.
//

import SwiftUI

struct ScrollViewOffsetPreferenceKey: PreferenceKey {
    static var defaultValue: CGFloat? = nil

    static func reduce(value: inout CGFloat?, nextValue: () -> CGFloat?) {
        value = value ?? nextValue()
    }
}
