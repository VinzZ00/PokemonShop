//
//  getPokemon.swift
//  PokeDeck
//
//  Created by Elvin Sestomi on 22/05/24.
//

import Foundation
import CoreData

class GetPokemon {
    func call() -> [NSPokemon] {
        // get from coredata
        let fetchRequest : NSFetchRequest<NSPokemon> = NSPokemon.fetchRequest()
        
        do {
            let pokemons = try Repository.shared.persistentContainer.viewContext.fetch(fetchRequest)
            return pokemons
        } catch {
            print("Error fetching from core data \(error.localizedDescription)")
        }
        
        return []
    }
}
