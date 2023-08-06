//
//  VoiceStyleView.swift
//
//
//  Created by Jaesung Lee on 2023/02/10.
//

import AVKit
import SwiftUI
import Combine

/// Data model to handle `AVAudioPlayerDelegate`
class VoicePlayer: NSObject, ObservableObject, AVAudioPlayerDelegate {
    @Published var audioPlayer: AVAudioPlayer?
    @Published var isPlaying: Bool = false
    @Published var duration: Int = 0
    
    var timerPublisher: AnyCancellable?
    
    func setup(with data: Data) {
        audioPlayer = try? AVAudioPlayer(data: data)
        self.duration = Int(audioPlayer?.duration ?? 0)
        audioPlayer?.delegate = self
    }
    
    func play() {
        if audioPlayer?.prepareToPlay() == true {
            timerPublisher = Timer.publish(every: 0.2, on: .main, in: .common).autoconnect()
                .sink(receiveValue: { value in
                    if let audioPlayer = self.audioPlayer {
                        self.duration = Int(audioPlayer.currentTime)
                    }
                })
            audioPlayer?.play()
            isPlaying = true
        }
    }
    
    func stop() {
        timerPublisher?.cancel()
        timerPublisher = nil
        audioPlayer?.stop()
        isPlaying = false
        self.duration = Int(audioPlayer?.duration ?? 0)
    }
    
    func audioPlayerDidFinishPlaying(_ player: AVAudioPlayer, successfully flag: Bool) {
        isPlaying = !flag
    }
}

public struct VoiceStyleView: View {
    @Environment(\.colorScheme) var colorScheme
    @Environment(\.appearance) var appearance
    @StateObject private var dataModel = VoicePlayer()
    
    let data: Data
    
    public var body: some View {
        HStack {
            Button(action: controlAudioPlayer) {
                Group {
                    if dataModel.isPlaying {
                        appearance.images.getPause(colorScheme).medium
                    } else {
                        appearance.images.getPlay(colorScheme).medium
                    }
                }
                .foregroundColor(.white)
            }
            
            Text(
                String(
                    format: "%02i:%02i",
                    dataModel.duration / 60,
                    dataModel.duration % 60
                )
            )
            .font(.footnote)
            .fontWeight(.semibold)
            .foregroundColor(.white)
        }
        .onAppear {
            dataModel.setup(with: data)
        }
    }
   
    public init(data: Data) {
        self.data = data
    }
    
    func controlAudioPlayer() {
        if dataModel.isPlaying {
            dataModel.stop()
        } else {
            dataModel.play()
        }
    }
}

