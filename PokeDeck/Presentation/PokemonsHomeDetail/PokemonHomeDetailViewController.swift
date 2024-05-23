//
//  PokemonHomeDetailViewController.swift
//  PokeDeck
//
//  Created by Elvin Sestomi on 23/05/24.
//

import UIKit

class PokemonHomeDetailViewController: UIViewController {
    
    let viewModel : PokemonHomeDetailViewModel
    let onDismiss : (PokemonDTO) -> Void
    
    init(viewModel: PokemonHomeDetailViewModel, onDismiss : @escaping (PokemonDTO) -> Void) {
        self.viewModel = viewModel
        self.onDismiss = onDismiss
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    var uiimageView : UIImageView = {
        var uimg = UIImageView()
        uimg.translatesAutoresizingMaskIntoConstraints = false
        return uimg
    }()
    
    var weightField : UITextField = {
        var tf = UITextField()
        tf.placeholder = "Pokemon Weight in Kg"
        tf.borderStyle = .roundedRect
        tf.textColor = .black
        tf.backgroundColor = .white
        tf.keyboardType = .numberPad
        tf.returnKeyType = .done
        tf.isUserInteractionEnabled = true
        
        tf.translatesAutoresizingMaskIntoConstraints = false
        return tf
    }()
    
    var nickNameField : UITextField  = {
        var tf = UITextField()
        tf.placeholder = "Pokemon Name"
        tf.borderStyle = .roundedRect
        tf.textColor = .black
        tf.backgroundColor = .white
        tf.keyboardType = .default
        tf.returnKeyType = .done
        tf.isUserInteractionEnabled = true

        tf.translatesAutoresizingMaskIntoConstraints = false
        return tf
    }()
    
    var nameLabel : UILabel = {
        var l = UILabel()
        l.font = UIFont.systemFont(ofSize: 20, weight: .medium)
        l.translatesAutoresizingMaskIntoConstraints = false
        return l
    }()
    
    var updateButton : UIButton = {
        var b = UIButton()
        
        b.setTitle("Update", for: .normal)
        b.backgroundColor = .systemGreen.withAlphaComponent(0.9)
        b.layer.cornerRadius = 8
        b.translatesAutoresizingMaskIntoConstraints = false
        b.tag = 1
        
        return b
    }()
    
    var deleteButton : UIButton = {
        var b = UIButton()
        
        b.setTitle("Delete", for: .normal)
        b.backgroundColor = .systemRed.withAlphaComponent(0.9)
        b.layer.cornerRadius = 8
        b.translatesAutoresizingMaskIntoConstraints = false
        b.tag = 2
        
        
        return b
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .white
        configureData()
        setupLayout()
    }
    
    @objc func buttonTapped(_ sender: UIButton) {
        if sender.tag == 1 { // Update Button
            viewModel.pokemonDTO.nickName = nickNameField.text ?? viewModel.pokemonDTO.nickName
            viewModel.pokemonDTO.weight = Float(weightField.text ?? "0") ?? viewModel.pokemonDTO.weight
            viewModel.update()
            navigationController?.popViewController(animated: true)
        } else if sender.tag == 2 { // Delete Button
            viewModel.delete()
            
            onDismiss(viewModel.pokemonDTO)
            
            navigationController?.popViewController(animated: true)
        }
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

extension PokemonHomeDetailViewController {
    func configureData() {
        uiimageView.image = viewModel.pokemonImage
        nameLabel.text = viewModel.pokemonDTO.pokemonName
        
        weightField.text = String(viewModel.pokemonDTO.weight)
        nickNameField.text = viewModel.pokemonDTO.nickName
        
        weightField.delegate  = self
        nickNameField.delegate = self
    }
    
    func setupLayout() {
        
        view.addSubview(uiimageView)
        view.addSubview(nameLabel)
        view.addSubview(weightField)
        view.addSubview(nickNameField)
        
        view.addSubview(updateButton)
        view.addSubview(deleteButton)
        
        updateButton.addTarget(self, action: #selector(buttonTapped(_:)), for: .touchUpInside)
        deleteButton.addTarget(self, action: #selector(buttonTapped(_:)), for: .touchUpInside)
        
        NSLayoutConstraint.activate([
            // UIImage
            uiimageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            uiimageView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            uiimageView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            uiimageView.heightAnchor.constraint(equalToConstant: 200),
            
            // Pokemon Name
            nameLabel.topAnchor.constraint(equalTo: uiimageView.bottomAnchor, constant: 10),
            nameLabel.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 16),
            nameLabel.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -16),
            
            // Pokemon Weight
            weightField.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 10),
            weightField.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 16),
            weightField.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -16),
            
            // Pokemon Nickname
            nickNameField.topAnchor.constraint(equalTo: weightField.bottomAnchor, constant: 10),
            nickNameField.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 16),
            nickNameField.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -16),
          
            // Update Button
            updateButton.topAnchor.constraint(equalTo: nickNameField.bottomAnchor, constant: 30),
            updateButton.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 16),
            updateButton.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -16),
            updateButton.heightAnchor.constraint(equalToConstant: 50),
            
            // Delete Button
            deleteButton.topAnchor.constraint(equalTo: updateButton.bottomAnchor, constant: 10),
            deleteButton.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 16),
            deleteButton.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -16),
            deleteButton.heightAnchor.constraint(equalToConstant: 50)
        ])
    }
}

extension PokemonHomeDetailViewController : UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}
