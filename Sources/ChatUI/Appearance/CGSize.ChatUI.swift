//
//  CGSize.ChatUI.swift
//  
//
//  Created by Jaesung Lee on 2023/02/19.
//

import Foundation

extension CGSize {
    /// Sizes for images used in ``ChatUI``.
    /// Use these values to ensure that images are displayed correctly in the chat user interface.
    /// ```swift
    /// Image.send
    ///     .scale(.Image.medium, contentMode: .fit)
    /// ```
    public class Image {
        /// 16 x 16
        public static var xSmall = CGSize(width: 16, height: 16)
        /// 20 x 20
        public static var small = CGSize(width: 20, height: 20)
        /// 24 x 24
        public static var medium = CGSize(width: 24, height: 24)
        /// 36 x 36
        public static var large = CGSize(width: 36, height: 36)
        /// 44 x 44
        public static var xLarge = CGSize(width: 48, height: 48)
        /// 64 x 64
        public static var xxLarge = CGSize(width: 64, height: 64)
        /// 90 x 90
        public static var xxxLarge = CGSize(width: 90, height: 90)
    }
}

