//
//  Camera.AVCapturePhotoCaptureDelegate.swift
//  
//
//  Created by Jaesung Lee on 2023/02/12.
//

import Combine
import AVFoundation

extension Camera: AVCapturePhotoCaptureDelegate {
    func photoOutput(_ output: AVCapturePhotoOutput, didFinishProcessingPhoto photo: AVCapturePhoto, error: Error?) {
        guard let data = photo.fileDataRepresentation() else { return }
        let _ = Empty<Void, Never>()
            .sink { _ in
                capturedItemPublisher.send(.photo(data))
            } receiveValue: { _ in }
    }
}
