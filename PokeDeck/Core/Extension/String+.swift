//
//  String+.swift
//  PokeDeck
//
//  Created by Elvin Sestomi on 22/05/24.
//

import Foundation
import CoreImage
import UIKit

extension String {
    func generateQRCode(/*from string: String*/) -> UIImage? {
        let data = self.data(using: .ascii)
        
        if let filter = CIFilter(name: "CIQRCodeGenerator") {
            filter.setValue(data, forKey: "InputMessage")
            
            let transform = CGAffineTransform(scaleX: 2, y: 7)
            
            if let output = filter.outputImage?.transformed(by: transform) {
                return UIImage(ciImage: output)
            }
        }
        return nil
    }
}
