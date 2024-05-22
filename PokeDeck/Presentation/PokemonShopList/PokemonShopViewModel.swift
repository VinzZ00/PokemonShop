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
        self.repository.apiDatasources.fetchPokemonList{
            result in
            switch result {
            case .success(let p) :
                //TODO: populate the pokemonData
                self.pokemonList.send(p)
                break
            case .failure(let err) :
                print("error when fetching data")
            }
            
        }
    }
}
