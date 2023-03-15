//
//  GiphyStyleView.swift
//  
//
//  Created by Jaesung Lee on 2023/02/09.
//

import SwiftUI
import GiphyUISDK

public struct GiphyStyleView: View {
    @State private var aspectRatio: CGFloat = 1
    let id: String
    
    public var body: some View {
        GiphyMediaView(gifID: id, aspectRatio: $aspectRatio)
            .frame(width: 120 * aspectRatio, height: 120)
            .clipShape(RoundedRectangle(cornerRadius: 21))
    }
    
    public init(id: String) {
        self.id = id
    }
}
