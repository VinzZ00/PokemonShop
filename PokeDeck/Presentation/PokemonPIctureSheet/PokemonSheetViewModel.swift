//
//  PokemonSheetViewModel.swift
//  PokeDeck
//
//  Created by Elvin Sestomi on 23/05/24.
//

import Foundation
import Combine
import UIKit

class PokemonSheetViewModel {
    
    var nfcReader : NFCScannerServices = NFCScannerServices.shared
    
    var image : CurrentValueSubject<UIImage?, Never> = CurrentValueSubject(nil)
    var cancellables = Set<AnyCancellable>()
    
    func fetchImage(url : String) {
        Repository.shared.apiDatasources.fetchPokemonImage(url:  URL(string: url) ?? URL(string:"https://placehold.co/96x96")!) { img in
            if let img = img {
                self.image.send(img)
            }
        }
    }
}


