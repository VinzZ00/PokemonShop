//
//  PokemonsHomeViewModel.swift
//  PokeDeck
//
//  Created by Elvin Sestomi on 23/05/24.
//

import Foundation
import UIKit
import RxSwift


class PokemonsHomeViewModel {
    
    var pokemonsDTO : BehaviorSubject<[(PokemonDTO, UIImage)]> = BehaviorSubject(value: [])
    
    var pokemonData : [(PokemonDTO, UIImage)] = []
    
    var cancellables = DisposeBag()
    
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
                        self.pokemonsDTO.on(.next(arr))
                    }
                }
        }
        self.pokemonsDTO.on(.next(arr))
        
        
    }
}
