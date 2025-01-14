import UIKit

class PokemonCollectionViewCell: UICollectionViewCell {
    private let titleLabel = UILabel()
    private let pokemonImageView = UIImageView()
    private let typesStackView = UIStackView()
    private let heightWeightStackView = UIStackView()
    private let mainStackView = UIStackView()
    private let leftStackView = UIStackView()

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupViews() {
        setUpContentView()
        setUpMainStackView()
        setUpLeftStackView()
        setUpTitle()
        setUpImage()
        setUpTypesStackView()
        setUpHeightWeightStackView()
    }
    
    func update(with pokemon: Pokemon) {
        resetViews()
        titleLabel.text = "#\(pokemon.id) \(pokemon.name.uppercased())"
        pokemonImageView.image = pokemon.image ?? UIImage(named: "placeholder")
        updateTypes(pokemon.types)
        updateHeightWeight(height: pokemon.height, weight: pokemon.weight)
    }
}

private extension PokemonCollectionViewCell {
    func setUpContentView() {
        contentView.backgroundColor = .systemBackground
        contentView.layer.cornerRadius = 8
        contentView.layer.masksToBounds = true
    }

    func setUpMainStackView() {
        mainStackView.axis = .horizontal
        mainStackView.spacing = 16
        mainStackView.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(mainStackView)
        NSLayoutConstraint.activate([
            mainStackView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10),
            mainStackView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -10),
            mainStackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10),
            mainStackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -10)
        ])
    }

    func setUpLeftStackView() {
        leftStackView.axis = .vertical
        leftStackView.spacing = 8
        leftStackView.alignment = .leading
        leftStackView.translatesAutoresizingMaskIntoConstraints = false
        leftStackView.setContentHuggingPriority(.defaultLow, for: .horizontal)
        leftStackView.setContentCompressionResistancePriority(.defaultLow, for: .horizontal)
        mainStackView.addArrangedSubview(leftStackView)
    }

    func setUpTitle() {
        titleLabel.font = .boldSystemFont(ofSize: 16)
        titleLabel.textAlignment = .left
        titleLabel.numberOfLines = 1
        titleLabel.textColor = .label
        leftStackView.addArrangedSubview(titleLabel)
    }

    func setUpImage() {
        pokemonImageView.contentMode = .scaleAspectFit
        pokemonImageView.clipsToBounds = true
        pokemonImageView.setContentHuggingPriority(.required, for: .horizontal)
        pokemonImageView.setContentCompressionResistancePriority(.required, for: .horizontal)
        mainStackView.addArrangedSubview(pokemonImageView)
        NSLayoutConstraint.activate([pokemonImageView.widthAnchor.constraint(equalTo: pokemonImageView.heightAnchor)])
    }

    func setUpTypesStackView() {
        typesStackView.axis = .horizontal
        typesStackView.spacing = 4
        typesStackView.alignment = .leading
        typesStackView.translatesAutoresizingMaskIntoConstraints = false
        leftStackView.addArrangedSubview(typesStackView)
    }

    func setUpHeightWeightStackView() {
        heightWeightStackView.axis = .vertical
        heightWeightStackView.spacing = 12
        heightWeightStackView.alignment = .leading
        heightWeightStackView.translatesAutoresizingMaskIntoConstraints = false
        leftStackView.addArrangedSubview(heightWeightStackView)
    }

    func updateTypes(_ types: [PokemonType]) {
        for type in types {
            let typeLabel = UILabel()
            typeLabel.text = type.name.capitalized
            typeLabel.font = .systemFont(ofSize: 14)
            typeLabel.textColor = .label
            typeLabel.backgroundColor = type.color
            typeLabel.layer.cornerRadius = 8
            typeLabel.layer.masksToBounds = true
            typeLabel.textAlignment = .center
            typeLabel.layer.sublayerTransform = CATransform3DMakeTranslation(8, 0, 0)
            let containerView = UIView()
            containerView.translatesAutoresizingMaskIntoConstraints = false
            typeLabel.translatesAutoresizingMaskIntoConstraints = false
            containerView.addSubview(typeLabel)
            NSLayoutConstraint.activate([
                typeLabel.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 4),
                typeLabel.leftAnchor.constraint(equalTo: containerView.leftAnchor, constant: 4),
                typeLabel.bottomAnchor.constraint(equalTo: containerView.bottomAnchor, constant: -4),
                typeLabel.rightAnchor.constraint(equalTo: containerView.rightAnchor, constant: -4),
                typeLabel.heightAnchor.constraint(greaterThanOrEqualToConstant: 24),
                typeLabel.widthAnchor.constraint(greaterThanOrEqualToConstant: 60)
            ])
            typesStackView.addArrangedSubview(containerView)
        }
    }

    func updateHeightWeight(height: Double, weight: Double) {
        let heightView = createCapsuleContainer(with: "📏 Height: \(height) m")
        let weightView = createCapsuleContainer(with: "⚖️ Weight: \(weight) kg")
        heightWeightStackView.addArrangedSubview(heightView)
        heightWeightStackView.addArrangedSubview(weightView)
    }
    
    func createCapsuleContainer(with text: String) -> UIView {
        let label = UILabel()
        label.text = text
        label.font = .systemFont(ofSize: 14)
        label.textColor = .label
        label.layer.masksToBounds = true
        label.textAlignment = .center
        label.layer.sublayerTransform = CATransform3DMakeTranslation(12, 0, 0)
        label.translatesAutoresizingMaskIntoConstraints = false
        let containerView = UIView()
        containerView.translatesAutoresizingMaskIntoConstraints = false
        containerView.backgroundColor = .secondarySystemBackground
        containerView.layer.cornerRadius = 8
        containerView.addSubview(label)
        NSLayoutConstraint.activate([
            label.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 4),
            label.leftAnchor.constraint(equalTo: containerView.leftAnchor, constant: 8),
            label.bottomAnchor.constraint(equalTo: containerView.bottomAnchor, constant: -4),
            label.rightAnchor.constraint(equalTo: containerView.rightAnchor, constant: -8),
            label.heightAnchor.constraint(greaterThanOrEqualToConstant: 28),
            label.widthAnchor.constraint(greaterThanOrEqualToConstant: 80)
        ])
        return containerView
    }

    func resetViews() {
        titleLabel.text = nil
        pokemonImageView.image = nil
        typesStackView.arrangedSubviews.forEach { $0.removeFromSuperview() }
        heightWeightStackView.arrangedSubviews.forEach { $0.removeFromSuperview() }
    }
}
