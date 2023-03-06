//
//  BoundsPreferenceKey.swift
//  
//
//  Created by Jaesung Lee on 2023/03/05.
//

import SwiftUI

/// The preference key to detect anchors of the bounds as `CGRect`
public struct BoundsPreferenceKey: PreferenceKey {
    public internal(set) static var defaultValue: [String: Anchor<CGRect>] = [:]
    
    public static func reduce(value: inout [String : Anchor<CGRect>], nextValue: () -> [String : Anchor<CGRect>]) {
        value.merge(nextValue()) { $1 }
    }
}
