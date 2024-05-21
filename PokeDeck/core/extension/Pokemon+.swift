//
//  Pokemon+PokemonDTO.swift
//  PokeDeck
//
//  Created by Elvin Sestomi on 22/05/24.
//

import Foundation
import UIKit


extension PokemonData {
    func mapToPokemonDTO() async throws -> PokemonDTO? {

        guard let url = URL(string: self.url) else {
            print("Pokemon Detail URL Error : \(self.url)")
            return nil
        }
        
        var pokemon : PokemonDTO? = nil
        
        await Repository.shared
            .apiDatasources.fetchPokemonDetail(url: url) {
                result in
                
                switch result {
                case .success(let pokemonDetail) :
                    
                    pokemon = PokemonDTO(nickName: "", pokemonName: pokemonDetail.name, pokemonDisplay: URL(string: pokemonDetail.sprite.front_shiny) ?? URL(string: "https://placehold.co/100x100")! , weight: pokemonDetail.weight)
//                    URLSession.shared.dataTask(with: URL(string: pokemonDetail.sprite.front_shiny) ?? URL(string: "https://placehold.co/100x100")!) {
//                        data, response, error in
//                        
//                        if let error = error {
//                            print("Error fetching the image : \(error)")
//                            
//                        }
//                        
//                        guard
//                            let resp = response as? HTTPURLResponse,
//                            resp.statusCode == 200,
//                            let imageData = data else {
//                            print("Invalid response")
//                            return
//                        }
//                        
//                        if let image = UIImage(data: imageData) {
//                            
//                            pokemon = PokemonDTO(nickName: "", pokemonName: pokemonDetail.name, pokemonDisplay: image, weight: pokemonDetail.weight)
//                            
//                        }
//                        
//                    }.resume()
                    
                    
                case .failure(let error) :
                    print("error while getting detail pokemon when mapping to pokemon : \(error)")
                }
            }
        
        return pokemon

    }
    
    
}

//extension PokemonDTO {
//    func mapToPokemon() -> PokemonData {
//        return 
//    }
//    
//}
