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
}


