//
//  StarWarsTransporterViewData.swift
//  StarWars
//
//  Created by Bharath on 15/05/19.
//  Copyright © 2019 Bharath Chandrashekar. All rights reserved.
//

import Foundation
import UIKit

enum CurrencyType {
    case credits
    case USD
}



class StarWarsTransporterViewData: StarWarsViewData, StarWarsTransporterDetailDataSource {
    
    
    let starWarsTransporter: Transporter
    var currency: CurrencyType
    var currencyValue: String = "---"
    let costConvertible: Bool
    
    
    init(withTransporter transporter: Transporter, currencyType type: CurrencyType = .credits ) {
        
        starWarsTransporter = transporter
        currency = type
        if let doubleValue = Double(starWarsTransporter.costInCredits) {
            currencyValue = "\(doubleValue)"
            costConvertible = true
        }
        else {
            costConvertible = false
        }
        super.init(withLengthValue: transporter.length, lengthUnit: .metres)
    }
    
    
    override var attributeValueMappingPair: [[StarWarsAttributeDisplay : String]] {
        
        return [ [.make:starWarsTransporter.manufacturer], [.cost:currencyValue], [.length:"\(currentLengthValue) \(currentLengthUnit.displayValue)"],
                 [.brand:starWarsTransporter.model], [.crew:starWarsTransporter.crew] ]
    }
    
    
    var unitForCost: CurrencyType {
        return currency
    }
}



extension StarWarsTransporterViewData {
    
    
    func toggleCurrency(withExchangeRate rate: Double = 1.0) {
        
        if costConvertible == true {
            
            if currency == .USD {
                
                //Go back to credits.
                
                currencyValue = "\(Double(starWarsTransporter.costInCredits)!)"
                currency = .credits
            }
            else if currency == .credits {
                
                //USD
                //Need the exchange rate.
                
                let doubleCurrencyValue: Double = Double(starWarsTransporter.costInCredits)!
                let dollarNumberValue: NSNumber = NSNumber(value: doubleCurrencyValue * rate)
                let formattedStr: String = dollarNumberValue.stringValueConvertedToDoubleWith(maxFractionDigits: 1)
                if formattedStr.isEmpty == false {
                    currencyValue = formattedStr
                }
                currency = .USD
            }
            
        }
    }
    
}

