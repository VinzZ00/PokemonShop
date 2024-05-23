//
//  QRCodeScannerViewController.swift
//  PokeDeck
//
//  Created by Elvin Sestomi on 23/05/24.
//

import UIKit
import AVFoundation

class QRCodeScannerViewController: UIViewController {
    
    var cameraService : CameraService = CameraService.shared
    var previewLayer : AVCaptureVideoPreviewLayer!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        // Setup the camera service
        cameraService.setup { qrCodeUrl in
            // Handle the QR code string here
            let modalVc = PokemonSheetViewController(url: qrCodeUrl)
            modalVc.delegate = self
            modalVc.modalPresentationStyle = .overFullScreen
            self.present(modalVc, animated: true)
        }
        
        // Add the AVCaptureVideoPreviewLayer to your view hierarchy
        previewLayer = cameraService.setupLivePreview()
        previewLayer.frame = view.layer.bounds
        
        view.layer.addSublayer(previewLayer)
        
        // Start the capture session
        DispatchQueue.global(qos: .background).async {
            self.cameraService.startRunning()
        }
        
    }
    
    override func viewDidLayoutSubviews() {
        if let tabBarHeight = tabBarController?.tabBar.frame.height {
            previewLayer.frame = CGRect(x: view.bounds.origin.x,
                                        y: view.bounds.origin.y,
                                        width: view.bounds.width,
                                        height: view.bounds.height - tabBarHeight)
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        self.cameraService.startRunning()
    }
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destination.
     // Pass the selected object to the new view controller.
     }
     */
    
}

extension QRCodeScannerViewController : PokemonSheetViewControllerDelegate {

    func didDismissModalViewController() {
        cameraService.startRunning()
    }
}
