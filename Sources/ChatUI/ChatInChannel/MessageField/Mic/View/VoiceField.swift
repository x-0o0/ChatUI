//
//  VoiceField.swift
//
//
//  Created by Jaesung Lee on 2023/02/13.
//

import SwiftUI
import Combine

public struct VoiceField: View {
    @Environment(\.colorScheme) var colorScheme
    @Environment(\.appearance) var appearance
    
    @StateObject private var dataModel = Recorder()
    @Binding var isPresented: Bool
    
    public var body: some View {
        HStack {
            Button(action: cancel) {
                appearance.images.getDelete(colorScheme).small
                    .foregroundColor(appearance.secondary)
            }
            .buttonStyle(.plain)
            .frame(width: 36, height: 36)
            .background { appearance.prominent.clipShape(Circle()) }
            
            Spacer()
            
            Text(
                String(
                    format: "%02i:%02i",
                    dataModel.recordingTime / 60,
                    dataModel.recordingTime % 60
                )
            )
            .font(appearance.footnote)
            .fontWeight(.semibold)
            .foregroundColor(appearance.prominent)
            
            Spacer()
            
            Button(action: dataModel.stopRecording) {
                appearance.images.getSend(colorScheme).small
                    .foregroundColor(appearance.prominent)
            }
            .buttonStyle(.plain)
            .frame(width: 36, height: 36)
            
        }
        .padding(4)
        .background { appearance.tint.clipShape(Capsule()) }
        .padding(16)
        .background {appearance.background }
        .onChange(of: dataModel.recordedData) { recordedData in
            if let data = recordedData {
                let _ = Empty<Void, Never>()
                    .sink(
                        receiveCompletion: { _ in
                            let style = MessageStyle
                                .voice(data)
                            sendMessagePublisher.send(style)
                        },
                        receiveValue: { _ in }
                    )
                isPresented = false
            }
        }
    }
    
    func cancel() {
        dataModel.cancelRecording()
        isPresented = false
    }
}

