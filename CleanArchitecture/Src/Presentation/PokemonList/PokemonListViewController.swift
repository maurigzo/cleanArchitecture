//
//  PokemonListViewController.swift
//  CleanArchitecture
//
//  Created by Gonzalo Mauricio Ramirez on 12/01/2025.
//

import UIKit
import Combine

class PokemonListViewController: UIViewController {
    private let collectionView: UICollectionView
    private let viewModel: PokemonListViewModel
    private let coordinator: Coordinator
    private var cancellables = Set<AnyCancellable>()
    private var pokemons: [Pokemon] = []
    
    init(viewModel: PokemonListViewModel, coordinator: Coordinator) {
        self.viewModel = viewModel
        self.coordinator = coordinator
        
        let layout = UICollectionViewFlowLayout()
        layout.minimumInteritemSpacing = 10
        layout.minimumLineSpacing = 10
        layout.sectionInset = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
        layout.itemSize = CGSize(width: UIScreen.main.bounds.width - 20, height: 200)
        self.collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Pokédex"
        setupCollectionView()
        bindViewModel()
        viewModel.fetchPokemonList()
    }
}

private extension PokemonListViewController {
    func setupCollectionView() {
        view.addSubview(collectionView)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.backgroundColor = .systemGray6
        collectionView.register(PokemonCollectionViewCell.self, forCellWithReuseIdentifier: "PokemonCell")
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: view.topAnchor),
            collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])
    }
    
    func bindViewModel() {
        viewModel.$pokemons
            .receive(on: DispatchQueue.main)
            .sink { [weak self] pokemons in
                self?.pokemons = pokemons
                self?.collectionView.reloadData()
            }
            .store(in: &cancellables)
    }
}

extension PokemonListViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        pokemons.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: "PokemonCell",
            for: indexPath
        ) as? PokemonCollectionViewCell else {
            return UICollectionViewCell()
        }
        let pokemon = pokemons[indexPath.item]
        cell.update(with: pokemon)
        return cell
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let pokemon = pokemons[indexPath.item]
        coordinator.showPokemonDetail(for: pokemon)
    }

    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let offsetY = scrollView.contentOffset.y
        let contentHeight = scrollView.contentSize.height
        let height = scrollView.frame.size.height

        if offsetY > contentHeight - height * 2 && !viewModel.isLoading {
            viewModel.fetchPokemonList()
        }
    }
}
