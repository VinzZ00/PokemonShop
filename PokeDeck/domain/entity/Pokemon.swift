//
//  PokemonDTO.swift
//  PokeDeck
//
//  Created by Elvin Sestomi on 21/05/24.
//

import Foundation

struct PokemonData : Codable {
    let name : String
    let url : String
}

struct PokemonLists : Codable {
    let results : [PokemonData]
}

struct PokemonDTO : Decodable {
    let name : String
    let sprite : Sprites
    let weight: Int
}

// MARK: Sprite (Image of the Pokemon) taking front only
struct Sprites : Decodable {
    let front_shiny : String
}
