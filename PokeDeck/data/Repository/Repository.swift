//
//  Repository.swift
//  PokeDeck
//
//  Created by Elvin Sestomi on 21/05/24.
//

import Foundation

class Repository {
    
    static let shared = Repository()
    
    let apiDatasources : PokemonAPIDataSource = PokemonAPIDataSource()
}
