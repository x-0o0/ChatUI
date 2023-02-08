//
//  PhotoStyleView.swift
//  
//
//  Created by Jaesung Lee on 2023/02/09.
//

import SwiftUI

public struct PhotoStyleView: View {
    let data: Data
    var uiImage: UIImage? {
        UIImage(data: data)
    }
    
    public var body: some View {
        if let uiImage = uiImage {
            Image(uiImage: uiImage)
                .resizable()
                .scaledToFill()
                .frame(width: 220, height: 120)
                .clipShape(RoundedRectangle(cornerRadius: 21))
        } else {
            placeholder
        }
    }
    
    var placeholder: some View {
        RoundedRectangle(cornerRadius: 21)
            .fill(Color(uiColor: .secondarySystemBackground))
            .frame(width: 220, height: 120)
            .overlay {
                VStack {
                    Image.downloadFailed.xLarge

                    Text(String.Message.failedPhoto)
                        .font(.footnote.bold())
                }
                    .foregroundColor(Color.secondary)
            }
    }
}
