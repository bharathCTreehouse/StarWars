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
    
    var currentLengthValue: String = "---"
    var currentLengthUnit: UnitForLength

    
    
    init(withLengthValue value: String, lengthUnit unit: UnitForLength) {
        
        currentLengthUnit = unit
        
        if let doubleValue = Double(value) {
            
            let numberValue: NSNumber = NSNumber(value: doubleValue)
            let formattedValue: String = numberValue.stringValueConvertedToDoubleWith(maxFractionDigits: 1)
            if formattedValue.isEmpty == false {
                currentLengthValue = formattedValue
            }
        }
       
    }
    
    
    
    var attributeValueMappingPair: [[StarWarsAttributeDisplay : String]] {
        return [[:]]
    }
    
    
    var unitForLengthOrHeight: UnitForLength {
        return currentLengthUnit
    }
    
    
    func font(forElement element: DetailUIElement) -> UIFont {
        if element == .attribute {
            return UIFont.boldSystemFont(ofSize: 18.0)
        }
        else {
            return UIFont.boldSystemFont(ofSize: 17.0)
        }
    }
    
    
    func textColor(forElement element: DetailUIElement) -> UIColor {
        if element == .attribute {
            return UIColor(red: 123.0/155.0, green: 208.0/155.0, blue: 254.0/155.0, alpha: 1.0)
        }
        else {
            return UIColor(red: 230.0/155.0, green: 230.0/155.0, blue: 230.0/155.0, alpha: 1.0)
        }
    }
}




extension StarWarsViewData {
    
    
    func toggleLengthUnit() {
        
        let length: Double? = Double(currentLengthValue)
        
        if let length = length {
            
            var value: NSNumber = NSNumber(value: 0.0)
            
            if currentLengthUnit == .metres {
                
                //convert to inches
                value = (NSNumber(value: length * 39.37))
                currentLengthUnit = .inches
            }
            else if currentLengthUnit == .inches {
                
                //convert to metres
                value = (NSNumber(value: length / 39.37))
                currentLengthUnit = .metres
                
            }
            updateCurrentLengthValue(withNumber: value)

        }
        
    }
    
    
    
    func updateCurrentLengthValue(withNumber value: NSNumber) {
        
        let formattedNumberStr: String = value.stringValueConvertedToDoubleWith(maxFractionDigits: 1)
        if formattedNumberStr.isEmpty == false {
            currentLengthValue = formattedNumberStr
        }
    }
}





