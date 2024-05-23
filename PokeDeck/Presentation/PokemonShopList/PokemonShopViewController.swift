//
//  ViewController.swift
//  PokeDeck
//
//  Created by Elvin Sestomi on 21/05/24.
//

import UIKit
import RxSwift

class PokemonShopViewController : UIViewController {
    
    var tableViewPokemon = UITableView()
    var viewModel : PokemonShopViewModel = PokemonShopViewModel()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "Pokemon Shop"
        navigationController?.navigationBar.prefersLargeTitles = true

        
        view.addSubview(tableViewPokemon)
        tableViewPokemon.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            tableViewPokemon.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            tableViewPokemon.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            tableViewPokemon.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            tableViewPokemon.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor)
        ])
        
        viewModel.pokemonList
            .observe(on: MainScheduler.instance)
            .subscribe(on: MainScheduler.instance)
            .subscribe { pokemonsData in
                self.viewModel.pokemonData = pokemonsData
                self.tableViewPokemon.reloadData()
            }.disposed(by: viewModel.cancellables)

//            .receive(on: DispatchQueue.main)
//            .sink { p in
//                self.viewModel.pokemonData = p
//                self.tableViewPokemon.reloadData()
//            }.store(in: &viewModel.cancellables)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        self.viewModel.fetchPokemonList()
        setupTableView()
    }
}

extension PokemonShopViewController : UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    
        let detailView = PokemonDetailViewController(viewModel: PokemonDetailViewModel(pokemonData: viewModel.pokemonData[indexPath.row]))
        
        self.navigationController?.pushViewController(detailView, animated: true)
        
    }
}

extension PokemonShopViewController : UITableViewDataSource {
    
    func setupTableView() {
        self.tableViewPokemon.dataSource = self
        self.tableViewPokemon.delegate = self
        self.tableViewPokemon.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.pokemonData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = viewModel.pokemonData[indexPath.row].name
        return cell
    }
    
    
}

