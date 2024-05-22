//
//  Pokemon+PokemonDTO.swift
//  PokeDeck
//
//  Created by Elvin Sestomi on 22/05/24.
//

import Foundation
import UIKit
import CoreData

extension PokemonData {
  
    func mapToPokemonDTO() async throws -> PokemonDTO? {

        guard let url = URL(string: self.url) else {
            print("Pokemon Detail URL Error : \(self.url)")
            return nil
        }
        
        var pokemon : PokemonDTO? = nil
        
        await Repository.shared
            .apiDatasources.fetchPokemonDetail(url: url) {
                result in
                
                switch result {
                case .success(let pokemonDetail) :
                    
                    pokemon = PokemonDTO(nickName: "", pokemonName: pokemonDetail.name, pokemonDisplay: URL(string: pokemonDetail.sprite.front_shiny) ?? URL(string: "https://placehold.co/100x100")! , weight: Float(pokemonDetail.weight))
                    
                case .failure(let error) :
                    print("error while getting detail pokemon when mapping to pokemon : \(error)")
                }
            }
        return pokemon
    }
}

extension PokemonDTO {
    func mapToNSPokemon() -> NSPokemon {
        let pokemon = NSPokemon(context: Repository.shared.persistentContainer.viewContext)
        pokemon.nickName = self.nickName
        pokemon.pokemonName = self.pokemonName
        pokemon.image = self.pokemonDisplay.absoluteString
        pokemon.weight = Float(self.weight)
        
        return pokemon
    }
    
}

extension NSPokemon {
    func mapToPokemonDTO() -> PokemonDTO {
        var toDTO = PokemonDTO(
            nickName: self.nickName!,
            pokemonName: self.pokemonName!,
            pokemonDisplay: URL(string: self.image!) ?? URL(string: "https://placehold.co/100x100")!,
            weight: self.weight
        )
        toDTO.id = self.id
        return toDTO
    }
}
