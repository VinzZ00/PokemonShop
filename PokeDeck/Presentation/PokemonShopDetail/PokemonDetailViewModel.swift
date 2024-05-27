//
//  PokemonDetailViewModle.swift
//  PokeDeck
//
//  Created by Elvin Sestomi on 22/05/24.
//

import Foundation

import RxSwift
import RxCocoa
import UIKit

class PokemonDetailViewModel {

    var pokemonDTO : BehaviorSubject<PokemonDTO> = BehaviorSubject(value: PokemonDTO(nickName: "", pokemonName: "error retrieving Pokemon name", weight: -1))
    var pokemonImage : BehaviorSubject<UIImage?>  = BehaviorSubject(value: nil)
    var qrPokemonImageUrl : UIImage = UIImage()
    var nickName = ""
    
    var cancellables = DisposeBag()
    
    
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
                    self.pokemonDTO.onNext(pokemon)
                    
                case .failure(let error) :
                    print("error while getting detail pokemon when mapping to pokemon : \(error)")
                }
            }
        
        self.pokemonDTO
            .subscribe(onNext: { [weak self]
            pokemonDTO in
            guard let self = self else { return }
            let url = pokemonDTO.pokemonDisplay
            Repository.shared.apiDatasources.fetchPokemonImage(url: url) { uiImage in
                self.pokemonImage.onNext(uiImage)
            }
            }).disposed(by: cancellables)
    }
}

extension PokemonDetailViewModel {
    func savePokemon(nName : String) {
        guard var currentPokemonDTO = try? pokemonDTO.value() else {
            print("Error while retrieving current Pokemon DTO in PoKemonDTO")
            return
        }

        currentPokemonDTO.nickName = nName
        pokemonDTO.onNext(currentPokemonDTO)
        
        SaveToCoreData().call(pokemon: currentPokemonDTO)
    }
}
