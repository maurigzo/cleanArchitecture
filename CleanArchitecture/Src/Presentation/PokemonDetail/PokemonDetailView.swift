//
//  PokemonDetailView.swift
//  CleanArchitecture
//
//  Created by Gonzalo Mauricio Ramirez on 13/01/2025.
//

import SwiftUI

struct PokemonDetailView: View {
    let pokemon: Pokemon
    
    var body: some View {
        ScrollView {
            VStack {
                header
                details
                Spacer()
            }
        }
    }
}
    
private extension PokemonDetailView {
    var header: some View {
        HStack {
            Spacer()
            VStack {
                Image(uiImage: pokemon.image ?? UIImage(named: "placeholder")!)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 160, height: 160)
                    .padding(.top, 24)
                Text("#\(pokemon.id) \(pokemon.name.uppercased())")
                    .font(.largeTitle)
                    .bold()
                    .padding(.vertical, 32)
            }
            Spacer()
        }
        .background(headerBackground)
    }
    
    var headerBackground: some View {
        LinearGradient(
            gradient: Gradient(colors: pokemon.types.map { Color(uiColor: $0.color) }),
            startPoint: .topLeading,
            endPoint: .bottomTrailing
        )
    }
    
    var details: some View {
        VStack(spacing: 16) {
            pokemonTypes
            weightAndHeight
            baseStats
        }
    }
    
    var pokemonTypes: some View {
        HStack {
            ForEach(pokemon.types, id: \.self) { pokemonType in
                Text(pokemonType.name.capitalized)
                    .font(.headline)
                    .padding(.horizontal, 32)
                    .padding(.vertical, 12)
                    .foregroundStyle(.primary)
                    .background(Color(uiColor:pokemonType.color))
                    .clipShape(Capsule())
            }
        }
    }
    
    var weightAndHeight: some View {
        HStack(spacing: 32) {
            kpi(key: "Weight", value: pokemon.weightWithUnit)
            kpi(key: "Height", value: pokemon.heightWithUnit)
        }
    }
    
    var baseStats: some View {
        VStack {
            baseStatsTitle
            ForEach(pokemon.stats, id: \.self) { stat in
                progressView(stat)
            }
        }
        .padding(.top, 8)
    }
    
    var baseStatsTitle: some View {
        Text("Base Stats")
            .font(.title)
    }
    
    func kpi(key: String, value: String) -> some View {
        VStack {
            Text(value)
                .font(.title)
            Text(key)
                .font(.callout)
                .foregroundStyle(.secondary)
        }
        .frame(minWidth: 100)
    }
    
    func progressView(_ stat: PokemonStat) -> some View {
        HStack {
            ProgressView(value: Double(stat.baseValue), total: Double(stat.maxValue)) {
                Text(stat.name.capitalized)
                    .font(.callout)
            }
            .progressViewStyle(.linear)
            .tint(stat.color)
            Text(stat.baseValue.description)
                .font(.callout)
        }
        .padding(.horizontal, 32)
    }
}
