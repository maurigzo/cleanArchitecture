//
//  PokemonType+Color.swift
//  CleanArchitecture
//
//  Created by Gonzalo Mauricio Ramirez on 14/01/2025.
//

import UIKit

extension PokemonType {
    var color: UIColor {
        switch name.lowercased() {
        case "normal":
            return UIColor(red: 168/255, green: 167/255, blue: 122/255, alpha: 1)
        case "fire":
            return UIColor(red: 238/255, green: 129/255, blue: 48/255, alpha: 1)
        case "water":
            return UIColor(red: 99/255, green: 144/255, blue: 240/255, alpha: 1)
        case "electric":
            return UIColor(red: 247/255, green: 208/255, blue: 44/255, alpha: 1)
        case "grass":
            return UIColor(red: 122/255, green: 199/255, blue: 76/255, alpha: 1)
        case "ice":
            return UIColor(red: 150/255, green: 217/255, blue: 214/255, alpha: 1)
        case "fighting":
            return UIColor(red: 194/255, green: 46/255, blue: 40/255, alpha: 1)
        case "poison":
            return UIColor(red: 163/255, green: 62/255, blue: 161/255, alpha: 1)
        case "ground":
            return UIColor(red: 226/255, green: 191/255, blue: 101/255, alpha: 1)
        case "flying":
            return UIColor(red: 169/255, green: 143/255, blue: 243/255, alpha: 1)
        case "psychic":
            return UIColor(red: 249/255, green: 85/255, blue: 135/255, alpha: 1)
        case "bug":
            return UIColor(red: 166/255, green: 185/255, blue: 26/255, alpha: 1)
        case "rock":
            return UIColor(red: 182/255, green: 161/255, blue: 54/255, alpha: 1)
        case "ghost":
            return UIColor(red: 115/255, green: 87/255, blue: 151/255, alpha: 1)
        case "dragon":
            return UIColor(red: 111/255, green: 53/255, blue: 252/255, alpha: 1)
        case "dark":
            return UIColor(red: 112/255, green: 87/255, blue: 70/255, alpha: 1)
        case "steel":
            return UIColor(red: 183/255, green: 183/255, blue: 206/255, alpha: 1)
        case "fairy":
            return UIColor(red: 214/255, green: 133/255, blue: 173/255, alpha: 1)
        default:
            return UIColor(red: 168/255, green: 167/255, blue: 122/255, alpha: 1)
        }
    }
}

