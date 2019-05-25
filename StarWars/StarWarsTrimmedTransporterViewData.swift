//
//  StarWarsTrimmedTransporterViewData.swift
//  StarWars
//
//  Created by Bharath on 25/05/19.
//  Copyright © 2019 Bharath Chandrashekar. All rights reserved.
//

import Foundation



class StarWarsTrimmedTransporterViewData: StarWarsTransporterViewData {
    
    
    override var attributeValueMappingPair: [[StarWarsAttributeDisplay : String]] {
        
        return [ [.name:starWarsTransporter.name], [.make: starWarsTransporter.manufacturer] ]
    }
    
}
