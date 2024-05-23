//
//  PokemonsHomeViewModel.swift
//  PokeDeck
//
//  Created by Elvin Sestomi on 23/05/24.
//

import Foundation
import UIKit
import Combine

class PokemonsHomeViewModel {
    
    var pokemonsDTO : CurrentValueSubject<[(PokemonDTO, UIImage)], Never> = CurrentValueSubject([])
    
    var pokemonData : [(PokemonDTO, UIImage)] = []
    
    var cancellables = Set<AnyCancellable>()
    
    func getAllPokemon() {
        var arr : [(PokemonDTO, UIImage)] = []
        GetPokemon().call().forEach { pokemon in
            Repository
                .shared
                .apiDatasources
                .fetchPokemonImage(url: URL(string: pokemon.imageUrl!) ?? URL(string:"https://placehold.co/96x96")!) { img in
                    if let img = img {
                        let tupples = (pokemon.mapToPokemonDTO(), img)
                        arr.append(tupples)
                        self.pokemonsDTO.send(arr)
                    }
                }
        }
        
        
    }
}
