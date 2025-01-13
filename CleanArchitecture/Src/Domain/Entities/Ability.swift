//
//  Ability.swift
//  CleanArchitecture
//
//  Created by Gonzalo Mauricio Ramirez on 13/01/2025.
//

import Foundation

struct Ability: Hashable {
    let ability: AbilityDetails
    let isHidden: Bool

    static func build(from dto: AbilityDTO) -> Self {
        .init(ability: .build(from: dto.ability), isHidden: dto.isHidden)
    }
}

struct AbilityDetails: Hashable {
    let name: String
    let url: String
    
    static func build(from dto: AbilityDetailsDTO) -> Self {
        .init(name: dto.name, url: dto.url)
    }
}
