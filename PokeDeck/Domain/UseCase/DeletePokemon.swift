//
//  DeletePokemon.swift
//  PokeDeck
//
//  Created by Elvin Sestomi on 22/05/24.
//

import Foundation

class DeletePokemon {
    func call(pokemon : PokemonDTO) {
        GetPokemon().call().forEach { p in
            if p.id == pokemon.id {
                Repository.shared.persistentContainer.viewContext.delete(p)
                do {
                    try Repository.shared.persistentContainer.viewContext.save()
                } catch {
                    print("Error deleting from core data \(error.localizedDescription)")
                }
            }
        }
    }
}
