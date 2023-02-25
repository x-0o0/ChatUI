//
//  ImageScale.ChatUI.swift
//  
//
//  Created by Jaesung Lee on 2023/02/12.
//

import SwiftUI

extension Image {
    /**
     Scales the view to the specified size while maintaining its aspect ratio.

     Use this method to resize an image or other view to a specific size while keeping its aspect ratio.

     - Parameters:
        - scale: The target size for the view, specified as a `CGSize`.
        - contentMode: The content mode to use when scaling the view. The default value is `ContentMode.aspectFit`.

     - Returns: A new view that scales the original view to the specified size.

     **Example usage:**

     ```swift
     Image("my-image")
         .scale(CGSize(width: 100, height: 100), contentMode: .fill)
     ```
     In this example, the Image view is scaled to a size of `100` points by `100` points while maintaining its aspect ratio. The `contentMode` parameter is set to `.fill`, which means that the image is stretched to fill the available space, possibly cutting off some of the edges.

     - Note: The `frame(width:height:)` modifier is used to set the size of the scaled view, and the `clipped()` modifier is used to ensure that the view does not extend beyond its frame.

     - SeeAlso: `resizable()`, `aspectRatio(contentMode:)`, `frame(width:height:)`
    */
    public func scale(_ scale: CGSize, contentMode: ContentMode) -> some View {
        self
            .resizable()
            .aspectRatio(contentMode: contentMode)
            .frame(width: scale.width, height: scale.height)
            .clipped()
    }
    
    /// 16 x 16, `.fit`
    public var xSmall: some View {
        self
            .scale(.Image.xSmall, contentMode: .fit)
    }
    
    /// 16 x 16, `.fill`
    public var xSmall2: some View {
        self
            .scale(.Image.xSmall, contentMode: .fill)
    }
    
    /// 20 x 20, `.fit`
    public var small: some View {
        self
            .scale(.Image.small, contentMode: .fit)
    }
    
    /// 20 x 20, `.fill`
    public var small2: some View {
        self
            .scale(.Image.small, contentMode: .fill)
    }
    
    /// 24 x 24, `.fit`
    public var medium: some View {
        self
            .scale(.Image.medium, contentMode: .fit)
    }
    
    /// 24 x 24, `.fill`
    public var medium2: some View {
        self
            .scale(.Image.medium, contentMode: .fill)
    }
    
    /// 36 x 36, `.fit`
    public var large: some View {
        self
            .scale(.Image.large, contentMode: .fit)
    }
    
    /// 36 x 36, `.fill`
    public var large2: some View {
        self
            .scale(.Image.large, contentMode: .fill)
    }
    
    /// 48 x 48, `.fit`
    public var xLarge: some View {
        self
            .scale(.Image.xLarge, contentMode: .fit)
    }
    
    /// 48 x 48, `.fill`
    public var xLarge2: some View {
        self
            .scale(.Image.xLarge, contentMode: .fill)
    }
    
    /// 64 x 64, `.fit`
    public var xxLarge: some View {
        self
            .scale(.Image.xxLarge, contentMode: .fit)
    }
    
    /// 64 x 64, `.fill`
    public var xxLarge2: some View {
        self
            .scale(.Image.xxLarge, contentMode: .fill)
    }
    
    /// 90 x 90, `.fit`
    public var xxxLarge: some View {
        self
            .scale(.Image.xxxLarge, contentMode: .fit)
    }
    
    /// 90 x 90, `.fill`
    public var xxxLarge2: some View {
        self
            .scale(.Image.xxxLarge, contentMode: .fill)
    }
}
