//
//  updateToCoreData.swift
//  PokeDeck
//
//  Created by Elvin Sestomi on 22/05/24.
//

import Foundation

class UpdateToCoreData {
    func call(newPokemon : PokemonDTO) {
        GetPokemon().call().forEach { pokemon in
            if newPokemon.id == pokemon.objectID {
                pokemon.nickName = newPokemon.nickName
                pokemon.weight = newPokemon.weight
                
                do {
                    try pokemon.managedObjectContext?.save()
                    print("Successfully updated to core data")
                } catch {
                    print("Error updating to core data \(error.localizedDescription)")
                }
                
            }
        }
        
    }
}
