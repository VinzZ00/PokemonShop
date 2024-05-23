//
//  UiViewController.swift
//  PokeDeck
//
//  Created by Elvin Sestomi on 22/05/24.
//

import UIKit

class PokemonDetailViewController : UIViewController {
    
    var nameLabel : UILabel = {
        var l = UILabel()
        l.font = UIFont.systemFont(ofSize: 16, weight: .medium)
        l.translatesAutoresizingMaskIntoConstraints = false
        return l
    }()
    
    var weightLabel : UILabel = {
        var l = UILabel()
        l.font = UIFont.systemFont(ofSize: 16)
        l.translatesAutoresizingMaskIntoConstraints = false
        return l
    }()
    
    var nickNameField : UITextField  = {
        var tf = UITextField()
        
        tf.borderStyle = .roundedRect
        tf.placeholder = "What you wanna call your Pokemon"
        tf.textColor = .black
        tf.backgroundColor = .white
        tf.keyboardType = .default
        tf.isUserInteractionEnabled = true
        tf.translatesAutoresizingMaskIntoConstraints = false
        return tf
    }()
    
    var contentView : UIView = {
        var v = UIView()
        v.translatesAutoresizingMaskIntoConstraints = false
        return v
    }()
    
    var pokemonImageView : UIImageView = {
        var imgView : UIImageView = UIImageView()
        imgView.translatesAutoresizingMaskIntoConstraints = false
        return imgView
    }()
    
    var qrImageView : UIImageView = {
        var imgView : UIImageView = UIImageView()
        imgView.translatesAutoresizingMaskIntoConstraints = false
        return imgView
    }()
    
    let viewModel : PokemonDetailViewModel
    
    init(viewModel: PokemonDetailViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        nickNameField.delegate = self
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Save", style: .plain, target: self, action: #selector(savePokemon(sender:)))
        
        contentSetup()

        // Do any additional setup after loading the view.
        viewModel.pokemonImage.receive(on: DispatchQueue.main).sink { image in
            self.pokemonImageView.image = image
        }.store(in: &viewModel.cancellables)
        
        viewModel.pokemonDTO.receive(on: DispatchQueue.main).sink { pokemon in
            self.nameLabel.text = pokemon.pokemonName
            self.weightLabel.text = "Weight: \(pokemon.weight)"
            self.qrImageView.image = pokemon.pokemonDisplay.absoluteString.generateQRCode() ?? UIImage(systemName: "qrcode")!
        }.store(in: &viewModel.cancellables)
        
    }
    
    @objc func savePokemon(sender: UIBarButtonItem) {
        viewModel.savePokemon(nName: nickNameField.text ?? "")
        self.navigationController?.popViewController(animated: true)
    }
    
    func contentSetup() {
        contentView.addSubview(pokemonImageView)
        contentView.addSubview(nameLabel)
        contentView.addSubview(weightLabel)
        contentView.addSubview(nickNameField)
        contentView.addSubview(qrImageView)
        
        view.addSubview(contentView)
        
        NSLayoutConstraint.activate([
            
            // ContentView
            contentView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            contentView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            contentView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            contentView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            
            // NickNameField
            nickNameField.topAnchor.constraint(equalTo: weightLabel.bottomAnchor, constant: 10),
            nickNameField.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            nickNameField.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            nickNameField.heightAnchor.constraint(equalToConstant: 50),
            
            // PokemonImageView
            pokemonImageView.topAnchor.constraint(equalTo: contentView.topAnchor),
            pokemonImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            pokemonImageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            pokemonImageView.heightAnchor.constraint(equalToConstant: 180),
            
            // NameLabel
            nameLabel.topAnchor.constraint(equalTo: pokemonImageView.bottomAnchor, constant: 10),
            nameLabel.leadingAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.leadingAnchor, constant: 16),
            nameLabel.trailingAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.trailingAnchor, constant: -16),
            
            // WeightLabel
            weightLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 10),
            weightLabel.leadingAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.leadingAnchor, constant: 16),
            weightLabel.trailingAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.trailingAnchor, constant: -16),
            
            //QRCodeImageView
            qrImageView.topAnchor.constraint(equalTo: nickNameField.bottomAnchor, constant: 10),
            qrImageView.leadingAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.leadingAnchor, constant: 16),
            qrImageView.trailingAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.trailingAnchor, constant: -16),
            
        ])
    }

    
}

extension PokemonDetailViewController : UITextFieldDelegate  {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}
