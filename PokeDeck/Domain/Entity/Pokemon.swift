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
    var results : [PokemonData]
}

struct Pokemon : Decodable {
    let name : String
    let sprites : Sprites
    let weight: Int
}

// MARK: Sprite (Image of the Pokemon) taking front only
struct Sprites : Decodable {
    let front_shiny : String
}
