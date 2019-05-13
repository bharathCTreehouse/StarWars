//
//  Character.swift
//  StarWars
//
//  Created by Bharath on 13/05/19.
//  Copyright © 2019 Bharath Chandrashekar. All rights reserved.
//

import Foundation


struct Character: Decodable {
    
    let name: String
    let birthYear: String
    let height: String
    let eyeColor: String
    let hairColor: String
    let homeworld: String
    

    enum InnerCodingKeys: String, CodingKey {
        case name = "name"
        case birthYear = "birth_year"
        case height = "height"
        case eyeColor = "eye_color"
        case hairColor = "hair_color"
        case homeworld = "homeworld"
    }
    
    init(from decoder: Decoder) throws {
        
        let internalContainer: KeyedDecodingContainer = try decoder.container(keyedBy: InnerCodingKeys.self)
        
        self.name = try internalContainer.decode(String.self, forKey: .name)
        self.birthYear = try internalContainer.decode(String.self, forKey: .birthYear)
        self.height = try internalContainer.decode(String.self, forKey: .height)
        self.eyeColor = try internalContainer.decode(String.self, forKey: .eyeColor)
        self.hairColor = try internalContainer.decode(String.self, forKey: .hairColor)
        self.homeworld = try internalContainer.decode(String.self, forKey: .homeworld)
        
    }
    
}


