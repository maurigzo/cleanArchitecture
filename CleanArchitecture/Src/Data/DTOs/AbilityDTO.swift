//
//  AbilityDTO.swift
//  CleanArchitecture
//
//  Created by Gonzalo Mauricio Ramirez on 13/01/2025.
//

struct AbilityDTO: Codable {
    let ability: AbilityDetailsDTO
    let isHidden: Bool
}

struct AbilityDetailsDTO: Codable {
    let name: String
    let url: String
}

struct SpriteDTO: Codable {
    let backDefault: String
}
