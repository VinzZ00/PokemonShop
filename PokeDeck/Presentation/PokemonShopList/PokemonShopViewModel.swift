//
//  ViewModel.swift
//  PokeDeck
//
//  Created by Elvin Sestomi on 22/05/24.
//

import Foundation
//import Combine
import RxSwift

class PokemonShopViewModel {
    var pokemonData : [PokemonData]  = []
    var repository = Repository.shared
    var pokemonList : BehaviorSubject<[PokemonData]> = BehaviorSubject(value: [])
    var cancellables = DisposeBag()
    
}

extension PokemonShopViewModel{
    func fetchPokemonList() {
        self.pokemonList.onNext(FetchAvailablePokemon().fetch())
    }
}
