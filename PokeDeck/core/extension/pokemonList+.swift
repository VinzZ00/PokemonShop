//
//  pokemonListDTO+.swift
//  PokeDeck
//
//  Created by Elvin Sestomi on 21/05/24.
//

import Foundation


extension PokemonLists {
    static func fromJson(jsonData : Data) -> [PokemonData] {
        let decoder = JSONDecoder()
        let pokemonList = try! decoder.decode(PokemonLists.self, from: jsonData)
        let pokemonDatas = pokemonList.results.map {
            PokemonData(name: $0.name
                           , url: $0.url)
        }
        return pokemonDatas
    }
}
