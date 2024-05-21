//
//  pokemonListDTO+.swift
//  PokeDeck
//
//  Created by Elvin Sestomi on 21/05/24.
//

import Foundation


extension pokemonListsDTO {
    static func fromJson(jsonData : Data) -> [PokemonDataDTO] {
        let decoder = JSONDecoder()
        let pokemonList = try! decoder.decode(pokemonListsDTO.self, from: jsonData)
        let pokemonDatas = pokemonList.results.map {
            PokemonDataDTO(name: $0.name
                           , url: $0.url)
        }
        return pokemonDatas
    }
}
