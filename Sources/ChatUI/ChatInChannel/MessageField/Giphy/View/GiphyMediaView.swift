//
//  GiphyMediaView.swift
//  
//
//  Created by Jaesung Lee on 2023/02/11.
//

import SwiftUI
import GiphyUISDK

/// The view that corresponds to `GPHMediaView` which shows `GPHMedia`. This view is used in ``GiphyStyleView`` for GIF message.
/// - NOTE: It's referred to [github.com/Giphy/giphy-ios-sdk](https://github.com/Giphy/giphy-ios-sdk/blob/main/Docs.md#gphmediaview)
struct GiphyMediaView: UIViewRepresentable {
    let gifID: String
    @State private var media: GPHMedia?
    @Binding var aspectRatio: CGFloat
    
    func makeUIView(context: Context) -> GPHMediaView {
        let mediaView = GPHMediaView()
        GiphyCore.shared.gifByID(gifID) { (response, error) in
            if let media = response?.data {
                DispatchQueue.main.sync { [self] in
                    self.aspectRatio = media.aspectRatio
                    self.media = media
                }
            }
        }
        return mediaView
    }
    
    func updateUIView(_ uiView: GPHMediaView, context: Context) {
        uiView.media = media
    }
}
