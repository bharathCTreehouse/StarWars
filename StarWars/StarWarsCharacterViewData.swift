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
    }
    
    override var attributeValueMappingPair: [[StarWarsAttributeDisplay : String]] {
        
        return [ [.born:starWarsCharacter.birthYear], [.home:starWarsCharacter.homeworld], [.height:starWarsCharacter.height],
                 [.eyes:starWarsCharacter.eyeColor], [.hair:starWarsCharacter.hairColor] ]
    }
    
}

