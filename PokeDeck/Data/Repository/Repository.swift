//
//  Repository.swift
//  PokeDeck
//
//  Created by Elvin Sestomi on 21/05/24.
//

import Foundation
import CoreData

class Repository {
    
    static let shared = Repository()
    
    private init() {}
    
    let persistentContainer : NSPersistentContainer = {
        var c = NSPersistentContainer(name: "PokemonStore")
        c.loadPersistentStores { desc, error in
            if let error = error {
                print("Core Data Failed to load \(error.localizedDescription)")
            }
        }
        return c
    }()
    
    let apiDatasources : PokemonAPIDataSource = PokemonAPIDataSource()
}
