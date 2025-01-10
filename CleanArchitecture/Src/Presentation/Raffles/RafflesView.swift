//
//  RafflesView.swift
//  CleanArchitecture
//
//  Created by jrobles on 07/01/2025.
//

import SwiftUI

private extension String {
    static var winner: Self { "Winner number:" }
    static var error: Self { "ha ocurrido un error" }
}

struct RafflesView: View {
    @StateObject var viewModel: RafflewsViewModel
    
    init(viewModel: RafflewsViewModel) {
        _viewModel = .init(wrappedValue: viewModel)
    }
    
    var body: some View {
        ZStack {
            ScrollView {
                VStack {
                    ForEach(viewModel.winners, id: \.uniqueIdentifier) { winner in
                        HStack {
                            Text(verbatim: .winner)
                            Text("\(winner.winningNumber)")
                        }
                        .padding(16)
                    }
                }
                .onAppear {
                    viewModel.load()
                }
            }
            
            if let _ = viewModel.error {
                VStack {
                    Text(verbatim: .error)
                    Text("\(String(describing: viewModel.error))")
                }
                .onTapGesture {
                    viewModel.error = nil
                }
            }
        }
    }
}
