//
//  FetchAvailablePokemon.swift
//  PokeDeck
//
//  Created by Elvin Sestomi on 21/05/24.
//

import Foundation

class FetchAvailablePokemon {
    let repository = Repository();
    
    func fetch() async -> PokemonDTO  {
        var data : Data
        
        if let localData =  UserDefaults.standard.data(forKey: "pokemonList") {
            data = localData
        } else {
            do {
                data = try await repository.apiDatasources.fetchPokemonList(completion: { res in
                    switch res {
                    case .success(pokemonDatas) :
                        
                    }
                })
            } catch {
                // TODO: give some dummy data handling the error so the app wont crash
                print("Error Fetching data")
            }
        }
        return
    }
}
