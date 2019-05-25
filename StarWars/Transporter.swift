//
//  Transporter.swift
//  StarWars
//
//  Created by Bharath on 13/05/19.
//  Copyright © 2019 Bharath Chandrashekar. All rights reserved.
//

import Foundation


struct Transporter: Decodable {
    
    let name: String
    let manufacturer: String
    let costInCredits: String
    let length: String
    let model: String
    let crew: String
}


extension Transporter: StarWarsSizeAndNameIdentifiable {
    
    var sizeOfComponent: Double {
        return Double(length) ?? 0.0
    }
    
    var nameOfComponent: String {
        return name
    }
}
