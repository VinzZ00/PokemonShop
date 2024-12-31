//
//  PokemonDTO.swift
//  PokeDeck
//
//  Created by Elvin Sestomi on 21/05/24.
//

import Foundation


// Making all of them Optional to avoid crashes
struct PokemonData : Codable {
    let name : String?
    let url : String?
}

struct PokemonLists : Codable {
    var results : [PokemonData]?
}

struct Pokemon : Codable {
    let name : String?
    let sprites : Sprites?
    let weight: Int?
}

// MARK: Sprite (Image of the Pokemon) taking front only
struct Sprites : Codable {
    let frontShiny : String?
    
    enum CodingKeys: String, CodingKey {
        case frontShiny = "front_shiny"
    }
}
