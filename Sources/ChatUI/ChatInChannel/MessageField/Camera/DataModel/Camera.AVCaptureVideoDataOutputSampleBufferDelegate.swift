//
//  Camera.AVCaptureVideoDataOutputSampleBufferDelegate.swift
//  
//
//  Created by Jaesung Lee on 2023/02/12.
//

import AVFoundation
import CoreImage

extension Camera: AVCaptureVideoDataOutputSampleBufferDelegate {
    func captureOutput(_ output: AVCaptureOutput, didOutput sampleBuffer: CMSampleBuffer, from connection: AVCaptureConnection) {
        guard let pixelBuffer = sampleBuffer.imageBuffer else { return }
        
        if connection.isVideoOrientationSupported,
           let videoOrientation = videoOrientationFor(deviceOrientation) {
            connection.videoOrientation = videoOrientation
        }

//        selectedVideoPreviewStream?(CIImage(cvPixelBuffer: pixelBuffer))
    }
}
