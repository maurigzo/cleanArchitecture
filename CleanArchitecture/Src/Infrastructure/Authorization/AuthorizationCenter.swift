//
//  AuthorizationCenter.swift
//  CleanArchitecture
//
//  Created by jrobles on 07/01/2025.
//

import Foundation
import Combine

private extension String {
    static var userLoggedInStatus: Self { "com.cleanArchitecture.userStatus" }
}

protocol AuthorizationCenterType {
    var userStatusChanged: PassthroughSubject<Bool, Never> { get }
    func login()
    func logout()
    func isUserAuthorized() -> Bool
}

/*
 For the purpose of displaying an infrastructure center's functionality this is simplified,
 this center should have its own UseCases to handle the data in a clean manner
 */
final class AuthorizationCenter: AuthorizationCenterType {
    static let shared = AuthorizationCenter()
    let userStatusChanged: PassthroughSubject<Bool, Never> = .init()
    private let userDefaults: UserDefaults
    private var userLoggedIn: Bool {
        userDefaults.bool(forKey: .userLoggedInStatus)
    }
    
    private init(
        userDefaults: UserDefaults = UserDefaults()
    ) {
        self.userDefaults = userDefaults
    }
}

// MARK: - AuthorizationCenterType
extension AuthorizationCenter {
    func login() {
        userDefaults.set(true, forKey: .userLoggedInStatus)
        userStatusChanged.send(true)
    }
    
    func logout() {
        userDefaults.set(false, forKey: .userLoggedInStatus)
        userStatusChanged.send(false)
    }
    
    func isUserAuthorized() -> Bool {
        return userLoggedIn
    }
}
