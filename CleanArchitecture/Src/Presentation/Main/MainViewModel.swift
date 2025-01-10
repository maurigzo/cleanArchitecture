//
//  MainViewModel.swift
//  CleanArchitecture
//
//  Created by jrobles on 07/01/2025.
//

import Combine
import Foundation

final class MainViewModel: ObservableObject {
    @Published var userLoggedIn: Bool
    private let authorizationCenter: AuthorizationCenterType
    lazy var cancellables = Set<AnyCancellable>()
    
    init(
        authorizationCenter: AuthorizationCenterType = AuthorizationCenter.shared
    ) {
        self.authorizationCenter = authorizationCenter
        self.userLoggedIn = authorizationCenter.isUserAuthorized()
        subscribeToAuthorization()
    }
    
    private func subscribeToAuthorization() {
        self.authorizationCenter.userStatusChanged
            .subscribe(on: DispatchQueue.global())
            .receive(on: DispatchQueue.main)
            .sink { [weak self] value in
                guard let self else { return }
                self.userLoggedIn = value
            }
            .store(in: &cancellables)
    }
    
    func logout() {
        authorizationCenter.logout()
    }
}

