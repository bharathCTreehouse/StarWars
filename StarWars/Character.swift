//
//  Character.swift
//  StarWars
//
//  Created by Bharath on 13/05/19.
//  Copyright © 2019 Bharath Chandrashekar. All rights reserved.
//

import Foundation


class Character: Decodable {
    
    let name: String
    let birthYear: String
    let height: String
    let eyeColor: String
    let hairColor: String
    let homeworld: String
    var home: String? = nil
    let vehicles: [String]
    let starships: [String]
    var listOfVehicles: [Transporter] = []
    var listOfStarships: [Transporter] = []
    
    
    enum CharacterCodingKeys: String, CodingKey {
        case name
        case birthYear
        case height
        case eyeColor
        case hairColor
        case homeworld
        case vehicles
        case starships
    }
    
    
    required init(from decoder: Decoder) throws {
        
        let container: KeyedDecodingContainer = try decoder.container(keyedBy: CharacterCodingKeys.self)
        
        self.name = try container.decode(String.self, forKey: .name)
        self.birthYear = try container.decode(String.self, forKey: .birthYear)
        self.height = try container.decode(String.self, forKey: .height)
        self.eyeColor = try container.decode(String.self, forKey: .eyeColor)
        self.hairColor = try container.decode(String.self, forKey: .hairColor)
        self.homeworld = try container.decode(String.self, forKey: .homeworld)
        self.vehicles = try container.decode([String].self, forKey: .vehicles)
        self.starships = try container.decode([String].self, forKey: .starships)
        
    }
    
}


extension Character {
    
    var homeURL: URL? {
        return URL(string: homeworld)
    }
}


extension Character: StarWarsSizeAndNameIdentifiable {
    
    var sizeOfComponent: Double {
        return Double(height) ?? 0.0
    }
    
    var nameOfComponent: String {
        return name
    }
}


