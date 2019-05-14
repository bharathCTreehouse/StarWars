//
//  StarWarsCharacterViewData.swift
//  StarWars
//
//  Created by Bharath on 14/05/19.
//  Copyright © 2019 Bharath Chandrashekar. All rights reserved.
//

import Foundation
import  UIKit


struct StarWarsCharacterViewData {
    
    let starWarsCharacter: Character
    
}

extension StarWarsCharacterViewData: StarWarsDetailDataSource {
    
    var attributeValueMappingPair: [[StarWarsAttributeDisplay : String]] {
        
        return [ [.born:starWarsCharacter.birthYear], [.home:starWarsCharacter.homeworld], [.height:starWarsCharacter.height],
        [.eyes:starWarsCharacter.eyeColor], [.hair:starWarsCharacter.hairColor] ]
    }
    
    var attributeColor: UIColor {
        return UIColor(red: 123.0/155.0, green: 208.0/155.0, blue: 254.0/155.0, alpha: 1.0)
    }
    var attributeFont: UIFont {
        return UIFont.boldSystemFont(ofSize: 18.0)
    }
    
    
    var attributeValueColor: UIColor {
        return UIColor(red: 230.0/155.0, green: 230.0/155.0, blue: 230.0/155.0, alpha: 1.0)
    }
    var attributeValueFont: UIFont {
        return UIFont.boldSystemFont(ofSize: 20.0)
    }
    
    
}
