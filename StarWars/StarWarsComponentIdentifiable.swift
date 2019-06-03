//
//  StarWarsComponentIdentifiable.swift
//  StarWars
//
//  Created by Bharath on 04/06/19.
//  Copyright © 2019 Bharath Chandrashekar. All rights reserved.
//

import Foundation

protocol StarWarsNameIdentifiable {
    var nameOfComponent: String { get }
}

protocol StarWarsSizeAndNameIdentifiable: StarWarsNameIdentifiable {
    var sizeOfComponent: Double { get }
}
