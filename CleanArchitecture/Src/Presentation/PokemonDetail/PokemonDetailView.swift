//
//  PokemonDetailView.swift
//  CleanArchitecture
//
//  Created by Gonzalo Mauricio Ramirez on 13/01/2025.
//

import SwiftUI

struct PokemonDetailView: View {
    private let pokemon: Pokemon
    
    init(pokemon: Pokemon) {
        self.pokemon = pokemon
    }
    
    var body: some View {
        Text(pokemon.name)
    }
}
