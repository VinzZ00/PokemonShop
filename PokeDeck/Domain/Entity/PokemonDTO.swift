//
//  PokemonDTO.swift
//  PokeDeck
//
//  Created by Elvin Sestomi on 21/05/24.
//

import Foundation
import UIKit
import CoreData

struct PokemonDTO {
    var id : NSManagedObjectID?
    var nickName : String?
    var pokemonName : String
    var pokemonDisplay : URL
    var weight : Float
    
    init(nickName: String, pokemonName: String, pokemonDisplay: URL = URL(string: "https://fakeimg.pl/96x96")!, weight: Float) {
        self.nickName = nickName
        self.pokemonName = pokemonName
        self.pokemonDisplay = pokemonDisplay
        self.weight = weight
    }
}
