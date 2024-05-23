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
    var handleQRCode : ((String) -> Void)!
    
    static let shared = CameraService()
    
    func setup(handleQRCode : @escaping (String) -> Void) {
        self.handleQRCode = handleQRCode;
        captureSession = AVCaptureSession()
//        captureSession.sessionPreset = .medium
        
        let deviceDiscovery = AVCaptureDevice.DiscoverySession(deviceTypes: [.builtInWideAngleCamera], mediaType: .video, position: .back)
        
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
    
    func startRunning() {
        DispatchQueue.global(qos: .background).async {
            self.captureSession.startRunning()
        }
    }
    
    func stopRunning() {
        captureSession.stopRunning()
    }
    
}

extension CameraService : AVCaptureMetadataOutputObjectsDelegate {
    
    func metadataOutput(_ output: AVCaptureMetadataOutput, didOutput metadataObjects: [AVMetadataObject], from connection: AVCaptureConnection) {
        stopRunning()
        
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
