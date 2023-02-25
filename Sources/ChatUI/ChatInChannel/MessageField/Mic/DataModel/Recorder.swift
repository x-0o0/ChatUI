//
//  Recorder.swift
//  
//
//  Created by Jaesung Lee on 2023/02/13.
//

import SwiftUI
import Combine
import AVFoundation

class Recorder: NSObject, ObservableObject {
    var audioRecorder: AVAudioRecorder?
    
    @Published var recordedData: Data?
    @Published var status: RecordStatus = .none {
        didSet {
            if status == .ready || oldValue == .none {
                startRecording()
            }
        }
    }
    @Published var recordingTime: Int = 0
    
    var timerPublisher: AnyCancellable?

    var documentURL: URL {
        FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
    }
    
    var voiceMessageURL: URL {
        documentURL.appendingPathComponent("voice-message.m4a")
    }
    
    enum RecordStatus: Hashable {
        case none
        case notAllowed
        case ready
        case recording
        case recorded
    }
    
    override init(){
        super.init()
        
        AVAudioSession.sharedInstance().requestRecordPermission() { [unowned self] allowed in
            DispatchQueue.main.async {
                if allowed {
                    // Start to record immediately
                    self.status = .ready
                } else {
                    self.status = .notAllowed
                }
            }
        }
    }
    
    /// Called from `didSet` of `status`
    func startRecording(){
        let recordingSession = AVAudioSession.sharedInstance()
        do {
            try recordingSession.setCategory(.playAndRecord, mode: .default)
            try recordingSession.setActive(true)
        } catch {
            self.status = .ready
        }
        
        let settings = [
            AVFormatIDKey: Int(kAudioFormatMPEG4AAC),
            AVSampleRateKey: 12000,
            AVNumberOfChannelsKey: 1,
            AVEncoderAudioQualityKey: AVAudioQuality.high.rawValue
        ]
        
        do {
            audioRecorder = try AVAudioRecorder(url: voiceMessageURL, settings: settings)
            audioRecorder?.delegate = self
            audioRecorder?.prepareToRecord()
            audioRecorder?.record()
            status = .recording
            timerPublisher = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
                .sink(receiveValue: { value in
                    self.recordingTime += 1
                })
        } catch {
            self.status = .ready
        }
    }
    
    func cancelRecording() {
        audioRecorder?.stop()
        audioRecorder?.deleteRecording()
        audioRecorder = nil
        timerPublisher?.cancel()
        timerPublisher = nil
    }
    
    func stopRecording() {
        audioRecorder?.stop()
        audioRecorder = nil
        timerPublisher?.cancel()
        timerPublisher = nil
    }
    
    func fetchRecordedFile() {
        do {
            let documentContents = try FileManager.default.contentsOfDirectory(at: documentURL, includingPropertiesForKeys: nil)
            if let url = documentContents.first(where: { $0.absoluteString.contains("voice-message") }) {
                self.recordedData = try Data(contentsOf: url)
                self.status = .recorded
            } else {
                self.status = .ready
            }
        } catch {
            self.status = .ready
        }
    }
}

extension Recorder: AVAudioPlayerDelegate, AVAudioRecorderDelegate {
    func audioRecorderDidFinishRecording(_ recorder: AVAudioRecorder, successfully flag: Bool) {
        if flag {
            fetchRecordedFile()
        } else {
            self.status = .ready
        }
    }
}
