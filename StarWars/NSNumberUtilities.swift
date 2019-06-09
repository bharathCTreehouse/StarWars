//
//  NSNumberUtilities.swift
//  StarWars
//
//  Created by Bharath on 08/06/19.
//  Copyright © 2019 Bharath Chandrashekar. All rights reserved.
//

import Foundation


extension NSNumber {
    
    
    func stringValueConvertedToDoubleWith(maxFractionDigits digitCount: Int) -> String {
        
        let numberFormatter: NumberFormatter = NumberFormatter.init()
        numberFormatter.maximumFractionDigits = digitCount
        
        if let formattedValue = numberFormatter.string(from: self) {
            return "\(Double(formattedValue) ?? 0.0)"
        }
        else {
            return ""
        }
    }
    
}
