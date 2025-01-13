//
//  PokemonListViewController.swift
//  CleanArchitecture
//
//  Created by Gonzalo Mauricio Ramirez on 12/01/2025.
//

import UIKit
import Combine

class PokemonListViewController: UIViewController {
    private let tableView = UITableView()
    private let viewModel: PokemonListViewModel
    private let coordinator: Coordinator
    private var cancellables = Set<AnyCancellable>()
    private var pokemons: [Pokemon] = []

    init(viewModel: PokemonListViewModel, coordinator: Coordinator) {
        self.viewModel = viewModel
        self.coordinator = coordinator
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
        bindViewModel()
        viewModel.fetchPokemonList()
    }

    private func setupTableView() {
        view.addSubview(tableView)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "PokemonCell")

        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.topAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])
    }

    private func bindViewModel() {
        viewModel.$pokemons
            .receive(on: DispatchQueue.main)
            .sink { [weak self] pokemons in
                self?.pokemons = pokemons
                self?.tableView.reloadData()
            }
            .store(in: &cancellables)
    }
}

extension PokemonListViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        pokemons.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "PokemonCell", for: indexPath)
        let pokemon = pokemons[indexPath.row]
        cell.textLabel?.text = pokemon.name
        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let pokemon = pokemons[indexPath.row]
        coordinator.showPokemonDetail(for: pokemon)
    }
}
