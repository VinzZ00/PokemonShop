//
//  PokemonDetailViewModle.swift
//  PokeDeck
//
//  Created by Elvin Sestomi on 22/05/24.
//

import Foundation
import Combine
import UIKit

class PokemonDetailViewModel {

    var pokemonDTO : CurrentValueSubject<PokemonDTO, Never> = CurrentValueSubject(PokemonDTO(nickName: "", pokemonName: "error retrieving Pokemon name", weight: -1))
    var pokemonImage : CurrentValueSubject<UIImage?, Never>  = CurrentValueSubject(nil)
    var qrPokemonImageUrl : UIImage = UIImage()
    var nickName = ""
    
    var cancellables = Set<AnyCancellable>()
    
    
    init(pokemonData : PokemonData) {
        
        guard let url = URL(string: pokemonData.url) else {
            print("Pokemon Detail URL Error : \(pokemonData.url)")
            return
        }
        
        Repository.shared
            .apiDatasources.fetchPokemonDetail(url: url) {
                result in
                
                switch result {
                case .success(let pokemonDetail) :
                    
                    let pokemon = PokemonDTO(nickName: "", pokemonName: pokemonDetail.name, pokemonDisplay: URL(string: pokemonDetail.sprites.front_shiny) ?? URL(string: "https://placehold.co/96x96")! , weight: Float(pokemonDetail.weight))
                    self.pokemonDTO.send(pokemon)
                    
                case .failure(let error) :
                    print("error while getting detail pokemon when mapping to pokemon : \(error)")
                }
            }
        
        self.pokemonDTO
            .map { $0.pokemonDisplay }
            .sink(receiveValue: {
                [weak self] url in
                guard let self = self else { return }
                self.fetchPokemonImage(url: url)
            })
            .store(in: &cancellables)
    }
}

extension PokemonDetailViewModel {
    func savePokemon(nName : String) {
        var pokemonDTO = self.pokemonDTO.value
        pokemonDTO.nickName = nName
        SaveToCoreData().call(pokemon: pokemonDTO)
    }
    
    func fetchPokemonImage(url: URL) {
        var uiImage : UIImage? = nil
        URLSession.shared.dataTask(with: url) { data, resp, err in
            if let err = err {
                print("masuk ke sini Error \(err)")
                return
            }
            
            guard let data = data else {
                print("gaad data")
                return
            }
            
            uiImage = UIImage(data: data)
            self.pokemonImage.send(uiImage)
            
        }.resume()
    }
}
