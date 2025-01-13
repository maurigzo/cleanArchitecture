//
//  ContentView.swift
//  CleanArchitecture
//
//  Created by jrobles on 07/01/2025.
//

import SwiftUI

private extension String {
    static var logout: Self { "Logout" }
}

struct MainView: View {
    @StateObject var viewModel: MainViewModel
    
    init(viewModel: MainViewModel) {
        _viewModel = .init(wrappedValue: viewModel)
    }
    var body: some View {
        NavigationView {
            VStack {
                if viewModel.userLoggedIn {
                    PokemonListViewControllerWrapper(viewModel: PokemonListViewModel())
                        .toolbar {
                            ToolbarItem(placement: .topBarTrailing) {
                                Text(verbatim: .logout)
                                    .onTapGesture {
                                        viewModel.logout()
                                    }
                            }
                        }
                } else {
                    LoginView(viewModel: LoginViewModel())
                }
            }
            .padding()
            
        }
    }}
