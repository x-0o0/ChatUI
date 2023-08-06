//
//  CapturedItemView.swift
//  
//
//  Created by Jaesung Lee on 2023/02/12.
//

import SwiftUI
import Combine

public struct CapturedItemView: View {
    @Environment(\.appearance) var appearance
    
    let itemType: CaptureType
    
    public enum CaptureType {
        case photo(_ data: Data)
        case video(_ data: Data)
    }
    
    public var body: some View {
        switch itemType {
        case .photo(let data):
            if let uiImage = UIImage(data: data) {
                Image(uiImage: uiImage)
                    .resizable()
                    .scaledToFill()
            } else {
                failedImage
            }
        case .video(let data):
            failedImage
        }
    }
    
    var failedImage: some View {
        Color(uiColor: .secondarySystemBackground)
            .overlay {
                VStack {
                    appearance.images.downloadFailed.xLarge

                    Text(String.Message.failedPhoto)
                        .font(appearance.footnote.bold())
                }
                    .foregroundColor(appearance.secondary)
            }
    }
}
