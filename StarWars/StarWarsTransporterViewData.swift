//
//  StarWarsTransporterViewData.swift
//  StarWars
//
//  Created by Bharath on 15/05/19.
//  Copyright © 2019 Bharath Chandrashekar. All rights reserved.
//

import Foundation



class StarWarsTransporterViewData: StarWarsViewData {
    
    let starWarsTransporter: Transporter
    
    init(withTransporter transporter: Transporter) {
        starWarsTransporter = transporter
    }
    
    
    override var attributeValueMappingPair: [[StarWarsAttributeDisplay : String]] {
        
        return [ [.make:starWarsTransporter.manufacturer], [.cost:starWarsTransporter.costInCredits], [.length:starWarsTransporter.length],
                 [.brand:starWarsTransporter.model], [.crew:starWarsTransporter.crew] ]
    }
    
}
