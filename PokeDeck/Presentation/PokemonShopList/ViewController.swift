//
//  ViewController.swift
//  PokeDeck
//
//  Created by Elvin Sestomi on 21/05/24.
//

import UIKit

class ViewController: UIViewController {
    
    var tableViewPokemon = UITableView()
    var viewModel : PokemonShopViewModel = PokemonShopViewModel()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "Pokemon Shop"
        navigationController?.navigationBar.prefersLargeTitles = true
        view.backgroundColor = .white
        
        view.addSubview(tableViewPokemon)
        tableViewPokemon.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            tableViewPokemon.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            tableViewPokemon.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            tableViewPokemon.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            tableViewPokemon.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor)
        ])
        
        viewModel.pokemonList
            .receive(on: DispatchQueue.main)
            .sink { p in
                self.viewModel.pokemonData = p
                self.tableViewPokemon.reloadData()
            }.store(in: &viewModel.cancellables)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        self.viewModel.fetchPokemonList()
        setupTableView()
    }
}

extension ViewController : UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("pokemon Name : \(viewModel.pokemonData[indexPath.row])")
        
        //TODO: redirect to the pokemon Detail Page
    }
}

extension ViewController : UITableViewDataSource {
    
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
