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
    var photoOutput : AVCaptureMetadataOutput!
    var videoPreviewLayer : AVCaptureVideoPreviewLayer!
    var handleQRCode : (String) -> Void
    
    init(handleQRCode : @escaping (String) -> Void) {
        self.handleQRCode = handleQRCode
    }
    
    func setup() {
        captureSession = AVCaptureSession()
//        captureSession.sessionPreset = .medium
        
        var deviceDiscovery = AVCaptureDevice.DiscoverySession(deviceTypes: [.builtInDualWideCamera], mediaType: .video, position: .back)
        
        guard let backCam = deviceDiscovery.devices.first else {
            print("No Camera Found")
            return
        }
        
        do {
            let photoInput = try AVCaptureDeviceInput(device: backCam)
            photoOutput = AVCaptureMetadataOutput()
            
            if captureSession.canAddInput(photoInput) && captureSession.canAddOutput(photoOutput) {
                captureSession.addInput(photoInput)
                captureSession.addOutput(photoOutput)
                
                photoOutput.setMetadataObjectsDelegate(self, queue: DispatchQueue.main)
                
                photoOutput.metadataObjectTypes = [AVMetadataObject.ObjectType.qr]
            }
        } catch {
            print("Error in setup cameraService with error :  \(error)")
        }
    }
    
    func setupLivePreview() -> AVCaptureVideoPreviewLayer{
        videoPreviewLayer = AVCaptureVideoPreviewLayer(session: captureSession)
        videoPreviewLayer.videoGravity = .resizeAspectFill
        videoPreviewLayer.connection?.videoOrientation = .portrait
        return videoPreviewLayer;
    }
    
    
}

extension CameraService : AVCaptureMetadataOutputObjectsDelegate {
    
    func metadataOutput(_ output: AVCaptureMetadataOutput, didOutput metadataObjects: [AVMetadataObject], from connection: AVCaptureConnection) {
        captureSession.stopRunning()
        
        if let metaDataObject = metadataObjects.first {
            guard let readableObject = metaDataObject as? AVMetadataMachineReadableCodeObject else { return }
            
            if readableObject.type == .qr {
                guard let stringValue = readableObject.stringValue else { return }
                
                //Haptic Notification when getting QR Code that are readable
                AudioServicesPlaySystemSound(SystemSoundID(kSystemSoundID_Vibrate))
                
                handleQRCode(stringValue)
            }
        }
    }
}
