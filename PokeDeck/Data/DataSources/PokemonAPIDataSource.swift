//
//  NetworkService.swift
//  PokeDeck
//
//  Created by Elvin Sestomi on 21/05/24.
//

import Foundation
import UIKit

class PokemonAPIDataSource {
    static let shared = PokemonAPIDataSource();
    
    var apiUrl : URL {
        
        guard let url = URL(string: "https://pokeapi.co/api/v2/pokemon")
        else {
            fatalError("API Host has failed to connect")
        }
        return url
    }
    
    func fetchPokemonList(completion : @escaping (Result<[PokemonData], Error>) -> Void) {
        
        // Adding endpoint to the host url
        var urlComponent : URLComponents = URLComponents(url: apiUrl, resolvingAgainstBaseURL: false)!
        urlComponent.queryItems = [URLQueryItem(name: "limit", value: "25")]
        
        guard let endPoint = urlComponent.url else {
            print("Error while creating endpoint URL : \(urlComponent.url?.absoluteString ?? "No url")")
            return
        }
        
        URLSession.shared.dataTask(with: endPoint) {
            data, response, error in
            
            do {
                if let error = error {
                    completion(.failure(error))
                }
                
                guard let data = data else {
                    let error = NSError(domain: "", code: -1, userInfo: [NSLocalizedDescriptionKey: "No data received"])
                    completion(.failure(error))
                    return
                }
                
                let pokemonDatas = PokemonLists.fromJson(jsonData: data)
                
                let encoder = JSONEncoder()
                let encodedPokemonData = try encoder.encode(pokemonDatas)
                
                UserDefaults.standard.set(encodedPokemonData, forKey: "pokemonList")
                
                
                completion(.success(pokemonDatas))
            } catch {
                completion(.failure(error))
            }
            
        }.resume()
        
        
        // Request Data from API IOS 15+
        //            let (data, _) = try await URLSession.shared.data(from: endPoint)
        //
        //            // Convert from JSON Data into [PokemonData] using static pokemonListDTO function
        //            let pokemonDatas = PokemonLists.fromJson(jsonData: data)
        //
        //            // Encode and save to User Default
        //            let encoder = JSONEncoder()
        //            let encodedPokemonData = try encoder.encode(pokemonDatas)
        //            UserDefaults.standard.set(encodedPokemonData, forKey: "pokemonList")
        //
        //            completion(.success(pokemonDatas))
        //
        
    }
    
    func fetchPokemonDetail(url : URL, completion: @escaping (Result<Pokemon, Error>) -> Void) {
        
        URLSession.shared.dataTask(with: url) {
            data, response, error in
            
            do {
                if let error = error {
                    completion(.failure(error))
                }
                
                guard let data = data else {
                    let error = NSError(domain: "", code: -1, userInfo: [NSLocalizedDescriptionKey: "No data received"])
                    completion(.failure(error))
                    return
                }
                
                let decoder = JSONDecoder()
                let pokemon = try decoder.decode(Pokemon.self, from: data)
                completion(.success(pokemon))
            } catch {
                completion(.failure(error))
            }
            
        }.resume()
        
        // IOS 15+
//        do {
//            let (data, _) = try await URLSession.shared.data(from: url)
//            
//            let decoder = JSONDecoder()
//            let pokemon = try decoder.decode(Pokemon.self, from: data)
//            completion(.success(pokemon))
//            
//        } catch {
//            completion(.failure(error))
//        }
    }
    
    func fetchPokemonImage(url: URL, completion : @escaping (UIImage?) -> Void) {
        var uiImage : UIImage? = nil
        URLSession.shared.dataTask(with: url) { data, resp, err in
            if let err = err {
                print("Error \(err)")
                return
            }
            
            guard let data = data else {
                print("gaad data")
                return
            }
            
            uiImage = UIImage(data: data)
            completion(uiImage)
            
        }.resume()
    }
    
    
}
