//
//  LoginView.swift
//  CleanArchitecture
//
//  Created by jrobles on 07/01/2025.
//

import SwiftUI

struct LoginView: View {
    var viewModel: LoginViewModel
    var body: some View {
        VStack {
            Text("Welcome to Clean Architecture")
            Text("Read the Challenge.MD file")
            Button(action: { viewModel.login() }) {
                Text("Login")
            }
            
        }
    }
}
