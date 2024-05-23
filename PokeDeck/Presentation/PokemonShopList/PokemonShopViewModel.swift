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
//        var pokemons = FetchAvailablePokemon().fetch()
        self.pokemonList.onNext(FetchAvailablePokemon().fetch())
//        self.repository.apiDatasources.fetchPokemonList{
//            result in
//            switch result {
//            case .success(let p) :
//                self.pokemonList.onNext(p)
//                break
//            case .failure(let err) :
//                print("error when fetching data Error :  \(err)")
//            }
//            
//        }
    }
}
