//
//  CameraView.swift
//
//
//  Created by Jaesung Lee on 2023/02/12.
//

import SwiftUI
import CoreImage
import AVFoundation

public struct CameraView: View {
    @Environment(\.colorScheme) var colorScheme
    @Environment(\.appearance) var appearance
    @Environment(\.dismiss) private var dismiss
    
    @StateObject private var dataModel = Camera()
    
    let onDismiss: () -> Void
    
    public var body: some View {
        VStack() {
            HStack {
                Button(action: {
                    dismiss()
                    onDismiss()
                }) {
                    appearance.images.close(colorScheme).medium
                        .foregroundColor(appearance.prominent)
                }
                
                Spacer()
                
                Button(action: dataModel.switchCaptureDevice) {
                    appearance.images.flip(colorScheme).medium
                        .foregroundColor(appearance.prominent)
                }
            }
            
            Spacer()
            
            Button(action: dataModel.takePhoto) {
                ZStack {
                    Circle()
                        .strokeBorder(appearance.prominent, lineWidth: 3)
                        .frame(width: 62, height: 62)
                    Circle()
                        .fill(appearance.prominent)
                        .frame(width: 50, height: 50)
                }
            }
            
        }
        .buttonStyle(.plain)
        .padding(.vertical, 64)
        .padding(.horizontal, 16)
        .background { Color.black }
        .ignoresSafeArea()
        .task { await dataModel.start() }
    }
    
    public init(onDismiss: @escaping () -> Void) {
        self.onDismiss = onDismiss
    }
}
