//
//  PokemonHomeDeatilViewModel.swift
//  PokeDeck
//
//  Created by Elvin Sestomi on 23/05/24.
//

import Foundation
import UIKit

class PokemonHomeDetailViewModel {
    
    var pokemonDTO : PokemonDTO
    var pokemonImage : UIImage
    
    init(pokemonDTO: PokemonDTO, pokemonImage: UIImage) {
        self.pokemonDTO = pokemonDTO
        self.pokemonImage = pokemonImage
    }
}

extension PokemonHomeDetailViewModel {
    func delete() {
        DeleteFromCoreData().call(pokemon: pokemonDTO)
    }
    
    func update() {
        UpdateToCoreData().call(newPokemon: pokemonDTO)
    }
    
}
