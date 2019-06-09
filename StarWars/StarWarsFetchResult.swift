//
//  StarWarsFetchResult.swift
//  StarWars
//
//  Created by Bharath on 14/05/19.
//  Copyright © 2019 Bharath Chandrashekar. All rights reserved.
//

import Foundation


class StarWarsFetchResult: Decodable {
    
    let count: Int
    let next: String?
    let previous: String?
}


class StarWarsPeopleFetchResult: StarWarsFetchResult {
    
    let people: [Character]
    
    enum OuterKeys: String, CodingKey {
        case people = "results"
    }
    
    required init(from decoder: Decoder) throws {
        
        let container: KeyedDecodingContainer = try decoder.container(keyedBy: OuterKeys.self)
        self.people = try container.decode([Character].self, forKey: .people)
        try super.init(from: decoder)
    }
}



class StarWarsMovableFetchResult: StarWarsFetchResult {
    
    let movables: [Transporter]
    
    enum OuterKeys: String, CodingKey {
        case movables = "results"
    }
    
    required init(from decoder: Decoder) throws {
        
        let container: KeyedDecodingContainer = try decoder.container(keyedBy: OuterKeys.self)
        self.movables = try container.decode([Transporter].self, forKey: .movables)
        try super.init(from: decoder)
    }
}
