//
//  StarWarsAttributeDisplay.swift
//  StarWars
//
//  Created by Bharath on 15/05/19.
//  Copyright © 2019 Bharath Chandrashekar. All rights reserved.
//

import Foundation

enum StarWarsAttributeDisplay: String {
    
    case born = "Born"
    case home = "Home"
    case eyes = "Eyes"
    case height = "Height"
    case hair = "Hair"
    case make = "Make"
    case cost = "Cost"
    case length = "Length"
    case brand = "Class"
    case crew = "Crew"
    
    var canBeConvertedToAlternateUnit: Bool {
        switch self {
            case .height, .cost: return true
            default: return false
        }
    }
    
}
