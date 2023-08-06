//
//  ChannelInfoView.swift
//  
//
//  Created by Jaesung Lee on 2023/02/09.
//

import SwiftUI

/**
 The view that displays the following channel information:
 
 - The image of the channel
 - The title of the channel
 - The subtitle of the channel
 */
public struct ChannelInfoView: View {
    @Environment(\.appearance) var appearance
    
    let imageURL: URL?
    let title: String
    let subtitle: String
    
    public var body: some View {
        HStack {
            AsyncImage(url: imageURL) { image in
                image.large2
                    .clipShape(Circle())
                    .padding(1)
                    .background {
                        appearance.border
                            .clipShape(Circle())
                    }
            } placeholder: {
                appearance.images.person.large2
                    .foregroundColor(appearance.secondary)
                    .clipShape(Circle())
            }
            
            VStack(alignment: .leading) {
                Text(title)
                    .font(appearance.title)
                    .foregroundColor(appearance.primary)
                
                Text(subtitle)
                    .font(appearance.subtitle)
                    .foregroundColor(appearance.secondary)
            }
        }
    }
    
    public init(imageURL: URL?, title: String, subtitle: String) {
        self.imageURL = imageURL
        self.title = title
        self.subtitle = subtitle
    }
}
