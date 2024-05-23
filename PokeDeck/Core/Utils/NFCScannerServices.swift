//
//  NFCScannerServices.swift
//  PokeDeck
//
//  Created by Elvin Sestomi on 22/05/24.
//

import Foundation
import CoreNFC

class NFCScannerServices : NSObject, NFCNDEFReaderSessionDelegate {
    
    static let shared = NFCScannerServices()
    
    var nfcSession : NFCNDEFReaderSession!
    var completion : ((String) -> Void)?
    
    private override init() {}
    
    func setup(completion : @escaping (String) -> Void) {
        
        guard NFCNDEFReaderSession.readingAvailable else {
            print("NFC capability is not available in this apps or device")
            return
        }
        
        self.completion = completion
        
        nfcSession = NFCNDEFReaderSession(delegate: self, queue: nil, invalidateAfterFirstRead: true)
        nfcSession.alertMessage = "Hold your Iphone near the NFC tag to scan it"
        nfcSession.begin()
    }
    
    func readerSession(_ session: NFCNDEFReaderSession, didInvalidateWithError error: any Error) {
        if let error = error as? NFCReaderError {
            switch error.code {
            case .readerSessionInvalidationErrorFirstNDEFTagRead, .readerSessionInvalidationErrorUserCanceled:
                break
            default :
                print("NFC error : \(error.localizedDescription)")
            }
        }
        session.invalidate()
    }
    
    func readerSession(_ session: NFCNDEFReaderSession, didDetectNDEFs messages: [NFCNDEFMessage]) {
        for message in messages {
            for record in message.records {
                if let string = String(data: record.payload, encoding: .utf8) {
                    print("NFC Card Detected !")
                    print("NFC Tag : \(string)")
                    
                    self.completion?(string);
                }
            }
        }
        session.invalidate()
    }
}
