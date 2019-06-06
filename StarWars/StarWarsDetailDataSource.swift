//
//  StarWarsDetailDataSource.swift
//  StarWars
//
//  Created by Bharath on 06/06/19.
//  Copyright © 2019 Bharath Chandrashekar. All rights reserved.
//

import Foundation
import UIKit


enum  DetailUIElement {
    case attribute
    case value
}


protocol StarWarsDetailDataSource {
    
    var attributeValueMappingPair: [ [StarWarsAttributeDisplay: String] ] { get }
    var unitForLengthOrHeight: UnitForLength { get }
    
    func font(forElement element: DetailUIElement) -> UIFont
    func textColor(forElement element: DetailUIElement) -> UIColor
    
}


protocol StarWarsTransporterDetailDataSource: StarWarsDetailDataSource {
    var unitForCost: CurrencyType { get }
}


extension StarWarsDetailDataSource {
    
    func font(forElement element: DetailUIElement) -> UIFont {
        if element == .attribute {
            return UIFont.systemFont(ofSize: UIFont.systemFontSize)
        }
        else {
            return UIFont.systemFont(ofSize: UIFont.systemFontSize - 2.0)
        }
    }
    
    func textColor(forElement element: DetailUIElement) -> UIColor {
        return UIColor.black
    }
    
}
