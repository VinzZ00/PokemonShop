//
//  FetchAvailablePokemon.swift
//  PokeDeck
//
//  Created by Elvin Sestomi on 21/05/24.
//

import Foundation

class FetchAvailablePokemon {
    let repository = Repository();
    
    func fetch() async -> [PokemonData]  {
        var pokemonData : [PokemonData] = [];
        
        if let localData =  UserDefaults.standard.data(forKey: "pokemonList") {
            let d = localData
            // Decoding Data into PokemonData
            let decoder = JSONDecoder()
            do {
                pokemonData = try decoder.decode([PokemonData].self, from: d)
            } catch {
                
                // if the local data error then we will replace the data from the remote REST API
                repository.apiDatasources.fetchPokemonList { result in
                    
                    switch result {
                    case .success(let pokemonDatas):
                        do {
                            // Encode and save to User Default
                            let encoder = JSONEncoder()
                            let encodedPokemonData = try encoder.encode(pokemonDatas)
                            UserDefaults.standard.set(encodedPokemonData, forKey: "pokemonList")
                        } catch {
                            print("Error saving data into User default, Error :  \(error)")
                        }
                        
                        pokemonData = pokemonDatas
                        
                    case .failure(let error) :

                        // MARK: handling error
                        print("Error fetching data \(error)")
                        
                    }
                }
            }
            
        } else {
            repository.apiDatasources.fetchPokemonList { result in
                
                switch result {
                case .success(let pokemonDatas):
                    do {
                        // Encode and save to User Default
                        let encoder = JSONEncoder()
                        let encodedPokemonData = try encoder.encode(pokemonDatas)
                        UserDefaults.standard.set(encodedPokemonData, forKey: "pokemonList")
                    } catch {
                        print("Error saving data into User default, Error :  \(error)")
                    }
                    
                    pokemonData = pokemonDatas
                    
                case .failure(let error) :

                    // MARK: handling error
                    print("Error fetching data \(error)")
                    
                }
            }
        }
        return pokemonData.sorted { $0.name < $1.name }
    }
}
