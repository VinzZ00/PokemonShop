//
//  SaveToCoreData.swift
//  PokeDeck
//
//  Created by Elvin Sestomi on 22/05/24.
//

import Foundation

class SaveToCoreData {
    func call(pokemon : PokemonDTO) {
        var nsPokemon = pokemon.mapToNSPokemon();
        do {
            try Repository.shared.persistentContainer.viewContext.save()
        } catch {
            print("Error saving to core data \(error.localizedDescription)")
        }
    }
}
