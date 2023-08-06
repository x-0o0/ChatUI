//
//  SendLocationButton.swift
//  
//
//  Created by Jaesung Lee on 2023/02/11.
//

import SwiftUI

struct SendLocationButton: View {
    @Environment(\.colorScheme) var colorScheme
    @Environment(\.appearance) var appearance
    
    let action: () -> Void
    
    var body: some View {
        Button(action: action) {
            VStack(spacing: 0) {
                Circle()
                    .foregroundColor(appearance.tint)
                    .frame(width: 48, height: 48)
                    .overlay {
                        appearance.images.getSend(colorScheme).medium
                            .foregroundColor(appearance.prominent)
                    }
                
                Image(systemName: "arrowtriangle.down.fill")
                    .font(appearance.footnote)
                    .cornerRadius(2)
                    .foregroundColor(appearance.tint)
                    .offset(x: 0, y: -5)
                    .padding(.bottom, 48 + 5 + 12)
            }
        }
    }
    
    public init(action: @escaping () -> Void) {
        self.action = action
    }
}
