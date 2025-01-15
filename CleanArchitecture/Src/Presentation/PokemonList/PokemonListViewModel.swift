//
//  PokemonListViewModel.swift
//  CleanArchitecture
//
//  Created by Gonzalo Mauricio Ramirez on 12/01/2025.
//

import Combine
import Foundation

class PokemonListViewModel: ObservableObject {
    @Published var pokemons: [Pokemon] = []
    @Published var isLoading: Bool = false
    private var currentOffset: Int = 0
    private let pageSize = 20
    private let fetchPokemonListUseCase: FetchPokemonListUseCaseType
    private var cancellables = Set<AnyCancellable>()

    init(fetchPokemonListUseCase: FetchPokemonListUseCaseType = FetchPokemonListUseCase()) {   
        self.fetchPokemonListUseCase = fetchPokemonListUseCase
    }
    
    func fetchPokemonList() {
        guard !isLoading else { return }

        DispatchQueue.main.async { [weak self] in
            self?.isLoading = true
        }

        fetchPokemonListUseCase.execute(limit: pageSize, offset: currentOffset)
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { completion in
                if case .failure(let error) = completion {
                    print("Error fetching Pokémon list: \(error)")
                }
            }, receiveValue: { [weak self] pokemons in
                guard let self = self else { return }
                self.pokemons.append(contentsOf: pokemons.sorted { $0.id < $1.id })
                self.currentOffset += self.pageSize
                DispatchQueue.main.async {
                    self.isLoading = false
                }
            })
            .store(in: &cancellables)
    }
}
