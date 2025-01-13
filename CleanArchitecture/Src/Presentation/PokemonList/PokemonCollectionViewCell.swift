//
//  PokemonCollectionViewCell.swift
//  CleanArchitecture
//
//  Created by Gonzalo Mauricio Ramirez on 13/01/2025.
//

import UIKit

class PokemonCollectionViewCell: UICollectionViewCell {
    private let titleLabel = UILabel()
    private let typesStackView = UIStackView()
    private let pokemonImageView = UIImageView()
    private let abilitiesStackView = UIStackView()
    private let moreButton = UIButton(type: .system)

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupViews() {
        contentView.backgroundColor = .systemGray6
        contentView.layer.cornerRadius = 8
        contentView.layer.masksToBounds = true

        titleLabel.font = .boldSystemFont(ofSize: 16)
        titleLabel.textAlignment = .left

        typesStackView.axis = .horizontal
        typesStackView.spacing = 8

        pokemonImageView.contentMode = .scaleAspectFit
        pokemonImageView.clipsToBounds = true

        abilitiesStackView.axis = .vertical
        abilitiesStackView.spacing = 4

        moreButton.setTitle("See more", for: .normal)
        moreButton.setTitleColor(.systemBlue, for: .normal)
        moreButton.contentHorizontalAlignment = .right

        // Stack vertical para contenido
        let mainStackView = UIStackView(arrangedSubviews: [titleLabel, typesStackView, pokemonImageView, abilitiesStackView, moreButton])
        mainStackView.axis = .vertical
        mainStackView.spacing = 8
        mainStackView.translatesAutoresizingMaskIntoConstraints = false

        contentView.addSubview(mainStackView)

        NSLayoutConstraint.activate([
            mainStackView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10),
            mainStackView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -10),
            mainStackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10),
            mainStackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -10)
        ])
    }

    func configure(with pokemon: Pokemon) {
        titleLabel.text = "#\(pokemon.id) \(pokemon.name.capitalized)"
        pokemonImageView.image = UIImage(named: "placeholder")
    }
}
