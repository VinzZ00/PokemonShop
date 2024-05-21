//
//  PokemonDTO.swift
//  PokeDeck
//
//  Created by Elvin Sestomi on 21/05/24.
//

import Foundation
import UIKit

struct PokemonDTO {
    let id : UUID = UUID()
    var nickName : String?
    var pokemonName : String
    var pokemonDisplay : URL
    var weight : Int
    
    init(nickName: String, pokemonName: String, pokemonDisplay: URL, weight: Int) {
        self.nickName = nickName
        self.pokemonName = pokemonName
        self.pokemonDisplay = pokemonDisplay
        self.weight = weight
    }
}
