//
//  StarWarsViewData.swift
//  StarWars
//
//  Created by Bharath on 15/05/19.
//  Copyright © 2019 Bharath Chandrashekar. All rights reserved.
//

import Foundation
import UIKit


enum UnitForLength {
    
    case metres
    case inches
    
    var displayValue: String {
        
        if self == .metres {
            return "m"
        }
        else if self == .inches {
            return "inc"
        }
        return ""
    }
}



class StarWarsViewData: StarWarsDetailDataSource {
    
    var currentLengthValue: String
    var currentLengthUnit: UnitForLength
    
    
    init(withLengthValue value: String, lengthUnit unit: UnitForLength) {
        currentLengthValue = value
        currentLengthUnit = unit
    }
    
    var attributeValueMappingPair: [[StarWarsAttributeDisplay : String]] {
        return [[:]]
    }
    
    var attributeColor: UIColor {
        return UIColor(red: 123.0/155.0, green: 208.0/155.0, blue: 254.0/155.0, alpha: 1.0)
    }
    var attributeFont: UIFont {
        return UIFont.boldSystemFont(ofSize: 20.0)
    }
    
    
    var attributeValueColor: UIColor {
        return UIColor(red: 230.0/155.0, green: 230.0/155.0, blue: 230.0/155.0, alpha: 1.0)
    }
    var attributeValueFont: UIFont {
        return UIFont.boldSystemFont(ofSize: 21.0)
    }
    
    
    
    func toggleLengthUnit() {
        
        let length: Double? = Double(currentLengthValue)
        
        if let length = length {
            
            if currentLengthUnit == .metres {
                
                //convert to inches
                currentLengthValue = String((length * 39.37))
                currentLengthUnit = .inches
            }
            else if currentLengthUnit == .inches {
                
                //convert to metres
                currentLengthValue = String((length / 39.37))
                currentLengthUnit = .metres

            }
        }
        
    }
    
}
