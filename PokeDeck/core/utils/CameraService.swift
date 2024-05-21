//
//  CameraView.swift
//  PokeDeck
//
//  Created by Elvin Sestomi on 21/05/24.
//
import UIKit
import Foundation
import SwiftUI
import AVFoundation

class CameraService : NSObject {
    var captureSession : AVCaptureSession!
    var photoOutput : AVCapturePhotoOutput!
    var videoPreviewLayer : AVCaptureVideoPreviewLayer!
    
    func setup(todoAfterSetupSession : () -> Void) {
        captureSession = AVCaptureSession()
        captureSession.sessionPreset = .medium
        
        guard let backCam = AVCaptureDevice.default(for: AVMediaType.video) else {
            print("No Camera Found")
            return
        }
        
        do {
            let photoInput = try AVCaptureDeviceInput(device: backCam)
            photoOutput = AVCapturePhotoOutput()
            
            if captureSession.canAddInput(photoInput) && captureSession.canAddOutput(photoOutput) {
                captureSession.addInput(photoInput)
                captureSession.addOutput(photoOutput)
                todoAfterSetupSession();
            }
        } catch {
            print("Error in setup cameraService with error :  \(error)")
        }
    }
    
    func setupLivePreview() -> AVCaptureVideoPreviewLayer{
        videoPreviewLayer = AVCaptureVideoPreviewLayer(session: captureSession)
        videoPreviewLayer.videoGravity = .resizeAspect
        videoPreviewLayer.connection?.videoOrientation = .portrait
        return videoPreviewLayer;
    }
    
    
}

extension CameraService : AVCaptureMetadataOutputObjectsDelegate {
    func metadataOutput(_ output: AVCaptureMetadataOutput, didOutput metadataObjects: [AVMetadataObject], from connection: AVCaptureConnection) {
        captureSession.stopRunning()
        
        if let metaDataObject = metadataObjects.first {
            guard let readableObject = metadataObjects as? AVMetadataMachineReadableCodeObject else { return }
            guard let stringValue = readableObject.stringValue else { return }
            
            //Haptic Notification when getting QR Code that are readable
            AudioServicesPlaySystemSound(SystemSoundID(kSystemSoundID_Vibrate))
        }
    }
}
