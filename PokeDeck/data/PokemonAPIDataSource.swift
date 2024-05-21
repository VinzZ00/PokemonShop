//
//  NetworkService.swift
//  PokeDeck
//
//  Created by Elvin Sestomi on 21/05/24.
//

import Foundation

class PokemonAPIDataSource {
    static let shared = PokemonAPIDataSource();
    
    var apiUrl : URL {
        guard let url = URL(string: "https://pokeapi.co/api/v2/pokemon")
        else {
            fatalError("API Host has failed to connect")
        }
        return url
    }
    
    func fetchPokemonList(completion : @escaping (Result<[PokemonData], Error>) -> Void) async {
        
        // Adding endpoint to the host url
        var endPoint = apiUrl.appending(
            queryItems: [URLQueryItem(name: "limit", value: "25")]
        )
        
        do {
            
            // Request Data from API
            let (data, _) = try await URLSession.shared.data(from: endPoint)
            
            // Convert from JSON Data into [PokemonData] using static pokemonListDTO function
            let pokemonDatas = PokemonLists.fromJson(jsonData: data)
            
            // Encode and save to User Default
            let encoder = JSONEncoder()
            let encodedPokemonData = try encoder.encode(pokemonDatas)
            UserDefaults.standard.set(encodedPokemonData, forKey: "pokemonList")
            
            completion(.success(pokemonDatas))
            
        } catch {
            completion(.failure(error))
        }
    }
    
    func fetchPokemonDetail(url : URL, completion: @escaping (Result<Pokemon, Error>) -> Void) async {
        do {
            let (data, _) = try await URLSession.shared.data(from: url)
            
            let decoder = JSONDecoder()
            let pokemon = try decoder.decode(Pokemon.self, from: data)
            completion(.success(pokemon))
            
        } catch {
            completion(.failure(error))
        }
    }
            
    
}
