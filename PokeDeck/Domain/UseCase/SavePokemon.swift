//
//  SaveToCoreData.swift
//  PokeDeck
//
//  Created by Elvin Sestomi on 22/05/24.
//

import Foundation

class SaveToCoreData {
    func call(pokemon : PokemonDTO) {
        let nsPokemon = pokemon.mapToNSPokemon();
        do {
            try (nsPokemon.managedObjectContext ?? Repository.shared.persistentContainer.viewContext).save()
        } catch {
            print("Error saving to core data \(error.localizedDescription)")
        }
    }
}
