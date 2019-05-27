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
            return "inches"
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
        return UIFont.boldSystemFont(ofSize: 18.0)
    }
    
    
    var attributeValueColor: UIColor {
        return UIColor(red: 230.0/155.0, green: 230.0/155.0, blue: 230.0/155.0, alpha: 1.0)
    }
    var attributeValueFont: UIFont {
        return UIFont.boldSystemFont(ofSize: 17.0)
    }
    
    
    
    func toggleLengthUnit() {
        
        let length: Double? = Double(currentLengthValue)
        
        if let length = length {
            
            let nf: NumberFormatter = NumberFormatter()
            nf.maximumFractionDigits = 1
            
            if currentLengthUnit == .metres {
                
                //convert to inches
                let value: NSNumber = (NSNumber(value: length * 39.37))
                currentLengthValue = nf.string(from: value) ?? ""
                currentLengthUnit = .inches
            }
            else if currentLengthUnit == .inches {
                
                //convert to metres
                let value: NSNumber = (NSNumber(value: length / 39.37))
                currentLengthValue = nf.string(from: value) ?? ""
                currentLengthUnit = .metres

            }
        }
        
    }
    
}
