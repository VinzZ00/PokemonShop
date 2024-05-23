//
//  ViewModel.swift
//  PokeDeck
//
//  Created by Elvin Sestomi on 22/05/24.
//

import Foundation
import Combine
class PokemonShopViewModel {
    var pokemonData : [PokemonData]  = []
    
    var repository = Repository.shared
    var pokemonList : CurrentValueSubject<[PokemonData], Never> = CurrentValueSubject([])
    var cancellables = Set<AnyCancellable>()
    
}

extension PokemonShopViewModel{
    func fetchPokemonList() {
        self.pokemonList.send(FetchAvailablePokemon().fetch{
            pokemonData in
            self.pokemonList.send(pokemonData)
        })
    }
}
