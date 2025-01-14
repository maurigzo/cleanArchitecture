//
//  PokemonStat.swift
//  CleanArchitecture
//
//  Created by Gonzalo Mauricio Ramirez on 14/01/2025.
//

import SwiftUI

struct PokemonStat: Hashable {
    let name: String
    let baseValue: Int
    let maxValue: Int = 255

    var color: Color {
        let percentage: Double = Double(baseValue) / Double(maxValue)
        if percentage <= 0.2 {
            return .red
        } else if percentage < 0.5 {
            return .yellow
        }
        return .green
    }

    static func build(from dto: PokemonStatDTO) -> Self {
        .init(name: dto.stat.name, baseValue: dto.baseStat)
    }
}
