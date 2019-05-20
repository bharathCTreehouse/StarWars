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
}


extension Character {
    
    var homeURL: URL? {
        return URL(string: homeworld)
    }
}


