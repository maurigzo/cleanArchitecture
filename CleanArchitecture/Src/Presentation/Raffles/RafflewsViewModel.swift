//
//  RafflewsViewModel.swift
//  CleanArchitecture
//
//  Created by jrobles on 07/01/2025.
//

import Foundation
import Combine

final class RafflewsViewModel: ObservableObject {
    @Published var winners: [RaffleModel] = []
    @Published var error: RaffleError?
    lazy var cancellables = Set<AnyCancellable>()
    private let fetchWinnersUC: FetchWinnersUseCaseType
    
    init(fetchWinnersUC: FetchWinnersUseCaseType = FetchWinnersUseCase()) {
        self.fetchWinnersUC = fetchWinnersUC
    }
    
    func load() {
        self.fetchWinnersUC.execute(allowedWinners: 10)
            .subscribe(on: DispatchQueue.global())
            .receive(on: DispatchQueue.main)
            .sink { [weak self] completion in
                if case .failure(let error) = completion {
                    self?.error = error
                }
            } receiveValue: { [weak self] value in
                guard let self else { return }
                self.winners = value
            }
            .store(in: &cancellables)
    }
}
