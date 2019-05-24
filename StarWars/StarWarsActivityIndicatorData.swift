//
//  StarWarsActivityIndicatorData.swift
//  StarWars
//
//  Created by Bharath on 24/05/19.
//  Copyright © 2019 Bharath Chandrashekar. All rights reserved.
//

import Foundation
import UIKit


class StarWarsActivityIndicatorData {
    
    var attributesForButton: [StarWarsActivityViewButtonAttribute]
    var attributeForIndicator: StarWarsActivityIndicatorAttribute
    var color: UIColor
    
    init(withButtonAttrs attrs: [StarWarsActivityViewButtonAttribute], activityIndicatorAttr attr: StarWarsActivityIndicatorAttribute, color: UIColor) {
        
        attributesForButton = attrs
        attributeForIndicator = attr
        self.color = color
        
    }
}


extension StarWarsActivityIndicatorData: StarWarsActivityViewDataSource {
    
    var buttonAttributes: [StarWarsActivityViewButtonAttribute] {
        return attributesForButton
    }
    
    var activityIndicatorAttribute: StarWarsActivityIndicatorAttribute {
        return attributeForIndicator
    }
    
    
    var backgroundColor: UIColor {
        return color
    }
    
}
