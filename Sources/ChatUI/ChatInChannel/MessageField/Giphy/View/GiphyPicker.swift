//
//  GiphyPicker.swift
//  
//
//  Created by Jaesung Lee on 2023/02/11.
//

import UIKit
import SwiftUI
import Combine
import GiphyUISDK

/**
 Picker for GIF provided by Giphy.
 
 - NOTE: It's referred to [github.com/Giphy/giphy-ios-sdk/issues/44](https://github.com/Giphy/giphy-ios-sdk/issues/44#issuecomment-1345202630)
 
 - IMPORTANT: When a GIF media is selected, ``sendMessagePublisher`` delivers the ID of the media via ``MessageStyle/media(_:)`` as an associated value.
 
 ```swift
 @EnvironmentObject var configuration: ChatConfiguration
 
 ...
 if let giphyKey = configuration.giphyKey {
    GiphyPicker(giphyKey: giphyKey)
 }
 ```
 */
public struct GiphyPicker: UIViewControllerRepresentable {
    @Environment(\.colorScheme) var colorScheme
    @Environment(\.dismiss) private var dismiss
    
    let giphyKey: String

    public func makeUIViewController(context: Context) -> GiphyViewController {
        Giphy.configure(apiKey: giphyKey)
        
        let controller = GiphyViewController()
        controller.swiftUIEnabled = true
        controller.mediaTypeConfig = [.gifs, .stickers, .recents]
        controller.delegate = context.coordinator
        controller.navigationController?.isNavigationBarHidden = true
        controller.navigationController?.setNavigationBarHidden(true, animated: false)
                
        GiphyViewController.trayHeightMultiplier = 1.0

        controller.theme = GPHTheme(
            type: colorScheme == .light
            ? .lightBlur
            : .darkBlur
        )
        
        return controller
    }
    
    public func updateUIViewController(_ uiViewController: UIViewControllerType, context: Context) {
        
    }
    
    public func makeCoordinator() -> Coordinator {
        return  GiphyPicker.Coordinator(parent: self)
    }
    
    public class Coordinator: NSObject, GiphyDelegate {
        
        var parent: GiphyPicker
        
        init(parent: GiphyPicker) {
            self.parent = parent
        }
        
        public func didDismiss(controller: GiphyViewController?) {
            self.parent.dismiss()
        }
        
        public func didSelectMedia(giphyViewController: GiphyViewController, media: GPHMedia) {
            // media.id
            DispatchQueue.main.async {
                let _ = Empty<Void, Never>()
                    .sink(
                        receiveCompletion: { _ in
                            let style = MessageStyle.media(
                                .gif(media.id)
                            )
                            sendMessagePublisher.send(style)
                    },
                        receiveValue: { _ in }
                    )
                
                self.parent.dismiss()
            }
        }
    }
}
