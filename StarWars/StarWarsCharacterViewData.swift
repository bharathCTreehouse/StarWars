//
//  StarWarsCharacterViewData.swift
//  StarWars
//
//  Created by Bharath on 14/05/19.
//  Copyright © 2019 Bharath Chandrashekar. All rights reserved.
//

import Foundation
import  UIKit


class StarWarsCharacterViewData: StarWarsViewData {
    
    let starWarsCharacter: Character
    
    
    init(withCharacter person: Character) {
        starWarsCharacter = person
        super.init(withLengthValue: person.height, lengthUnit: .metres)
    }
    
    
    override var attributeValueMappingPair: [[StarWarsAttributeDisplay : String]] {
        
        return [ [.born:starWarsCharacter.birthYear], [.home:starWarsCharacter.home ?? "---"], [.height:"\(currentLengthValue) \(currentLengthUnit.displayValue)"],
                 [.eyes:starWarsCharacter.eyeColor], [.hair:starWarsCharacter.hairColor] ]
    }
}

