//
//  SpritesDTO.swift
//  CleanArchitecture
//
//  Created by Gonzalo Mauricio Ramirez on 14/01/2025.
//

struct SpritesDTO: Codable {
    let other: OtherSpritesDTO
}

struct OtherSpritesDTO: Codable {
    let officialArtwork: OfficialArtworkDTO
    
    enum CodingKeys: String, CodingKey {
        case officialArtwork = "official-artwork"
    }
}

struct OfficialArtworkDTO: Codable {
    let frontDefault: String
}
