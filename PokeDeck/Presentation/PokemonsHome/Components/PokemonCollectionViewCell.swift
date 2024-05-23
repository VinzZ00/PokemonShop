//
//  PokemonCollectionViewCell.swift
//  PokeDeck
//
//  Created by Elvin Sestomi on 23/05/24.
//

import Foundation
import UIKit

class PokemonCollectionViewCell : UICollectionViewCell {
    static let identifier = "PokemonCollectionViewCell"
    private let imageView = UIImageView(frame: .zero)
    private let nameLabel = UILabel(frame : .zero)
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension PokemonCollectionViewCell {
    func setupCell(data : (PokemonDTO, UIImage)) {
        nameLabel.text = data.0.nickName
        nameLabel.textAlignment = .center
        imageView.image = data.1
    }
    
    func setup() {
        imageView.translatesAutoresizingMaskIntoConstraints = false
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        backgroundColor = .white
        addSubview(imageView)
        addSubview(nameLabel)
        
        NSLayoutConstraint.activate([
            
            // Image View Layout Constraint
            imageView.topAnchor.constraint(equalTo: self.topAnchor),
            imageView.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            imageView.heightAnchor.constraint(equalToConstant: 96),
            imageView.widthAnchor.constraint(equalToConstant: 96),
                
            // Name Label Layout Constraint
            nameLabel.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 5),
            nameLabel.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            nameLabel.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            nameLabel.widthAnchor.constraint(equalTo: self.widthAnchor)
        ])
    }
}
