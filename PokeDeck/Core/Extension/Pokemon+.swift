//
//  Pokemon+PokemonDTO.swift
//  PokeDeck
//
//  Created by Elvin Sestomi on 22/05/24.
//

import Foundation
import UIKit
import CoreData


extension PokemonDTO {
    func mapToNSPokemon() -> NSPokemon {
        let pokemon = NSPokemon(context: Repository.shared.persistentContainer.viewContext)
        pokemon.nickName = self.nickName
        pokemon.pokemonName = self.pokemonName
        pokemon.image = self.pokemonDisplay.absoluteString
        pokemon.weight = Float(self.weight)
        
        return pokemon
    }
    
}

extension NSPokemon {
    func mapToPokemonDTO() -> PokemonDTO {
        var toDTO = PokemonDTO(
            nickName: self.nickName!,
            pokemonName: self.pokemonName!,
            pokemonDisplay: URL(string: self.image!) ?? URL(string: "https://placehold.co/96x96")!,
            weight: self.weight
        )
        toDTO.id = self.objectID
        return toDTO
    }
}
