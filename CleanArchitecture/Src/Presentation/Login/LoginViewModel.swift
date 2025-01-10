//
//  LoginViewModel.swift
//  CleanArchitecture
//
//  Created by jrobles on 07/01/2025.
//

import Combine

final class LoginViewModel: ObservableObject {
    private let authorizationCenter: AuthorizationCenterType
    
    init(authorizationCenter: AuthorizationCenterType = AuthorizationCenter.shared) {
        self.authorizationCenter = authorizationCenter
    }
    
    func login() {
        authorizationCenter.login()
    }
}
