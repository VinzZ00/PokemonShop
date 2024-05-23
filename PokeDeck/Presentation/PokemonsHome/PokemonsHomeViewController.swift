//
//  PokemonsViewController.swift
//  PokeDeck
//
//  Created by Elvin Sestomi on 23/05/24.
//

import UIKit
import RxSwift

class PokemonsHomeViewController: UIViewController {

    let viewModel : PokemonsHomeViewModel = PokemonsHomeViewModel()
    let pokemonCollection : UICollectionView = {
        
        var cvLayout = UICollectionViewFlowLayout()
        
        cvLayout.scrollDirection = .vertical
        cvLayout.itemSize = CGSize(width: 110, height: 140)
        cvLayout.minimumLineSpacing = 5
        cvLayout.minimumInteritemSpacing = 5
        
        
        var cv = UICollectionView(frame: .zero, collectionViewLayout: cvLayout)
        cv.register(PokemonCollectionViewCell.self, forCellWithReuseIdentifier: PokemonCollectionViewCell.identifier)
        cv.translatesAutoresizingMaskIntoConstraints = false
       return cv
    }()

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        title = "Your Pokemons"
        setupCollection()
        
        // Do any additional setup after loading the view.
        viewModel.pokemonsDTO
            .observe(on: MainScheduler.instance)
            .subscribe(on: MainScheduler.instance)
            .subscribe(onNext: { [weak self] pokemons in
                
                print("Pokemons : \(pokemons.count)")
                
                self?.viewModel.pokemonData = pokemons
                self?.pokemonCollection.reloadData()
            }).disposed(by: viewModel.cancellables)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        viewModel.getAllPokemon()
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}



extension PokemonsHomeViewController : UICollectionViewDataSource, UICollectionViewDelegate {
    
    func setupCollection() {
        pokemonCollection.delegate = self
        pokemonCollection.dataSource = self
        
        view.addSubview(pokemonCollection)
        
        NSLayoutConstraint.activate([
            pokemonCollection.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            pokemonCollection.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            pokemonCollection.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            pokemonCollection.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor)
        ])
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        viewModel.pokemonData.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PokemonCollectionViewCell.identifier, for: indexPath) as? PokemonCollectionViewCell else {
            return UICollectionViewCell()
        }
        
        let data = viewModel.pokemonData[indexPath.row]
        cell.setupCell(data: data)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
//        print("Selected \(viewModel.pokemonData[indexPath.row].0.nickName)")
        let vm = PokemonHomeDetailViewModel(pokemonDTO: viewModel.pokemonData[indexPath.row].0, pokemonImage: viewModel.pokemonData[indexPath.row].1)
        let vc = PokemonHomeDetailViewController(viewModel: vm) {
            pokemon in
            self.viewModel.pokemonData.removeAll { pd in
                pokemon.id == pd.0.id
            }
            self.pokemonCollection.reloadData()
        }
        navigationController?.pushViewController(vc, animated: true)
    }
    
}
