//
//  StarWarsDetailDataSource.swift
//  StarWars
//
//  Created by Bharath on 14/05/19.
//  Copyright © 2019 Bharath Chandrashekar. All rights reserved.
//

import Foundation
import UIKit


protocol StarWarsDetailDataSource {
    
    var attributeValueMappingPair: [ [StarWarsAttributeDisplay: String] ] { get }
    
    //Separate protocol for this??
    
    var attributeColor: UIColor { get }
    var attributeFont: UIFont { get }
    
    var attributeValueColor: UIColor { get }
    var attributeValueFont: UIFont { get }
}



class StarWarsDetailTableViewDataSource: NSObject, UITableViewDataSource {
    
    let data: StarWarsDetailDataSource
    
    
    required init(withDetailDataSource dataSource: StarWarsDetailDataSource) {
        data = dataSource
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return data.attributeValueMappingPair.count
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let mappingPair: [StarWarsAttributeDisplay: String] = data.attributeValueMappingPair[indexPath.row]
        let attribute: StarWarsAttributeDisplay = mappingPair.keys.first!
        
        if attribute.canBeConvertedToAlternateUnit == false {
            
            let cell: StarWarsDetailTableViewCell = tableView.dequeueReusableCell(withIdentifier: "detailCell", for: indexPath) as! StarWarsDetailTableViewCell
            
            cell.attributeLabel.textColor = data.attributeColor
            cell.attributeLabel.font = data.attributeFont
            
            cell.valueLabel.textColor = data.attributeValueColor
            cell.valueLabel.font = data.attributeValueFont
            
            cell.attributeLabel.text = attribute.rawValue
            cell.valueLabel.text = mappingPair.values.first!
            
            return cell
        }
        else {
            
            let cell: StarWarsWithAccessoryDetailTableViewCell = tableView.dequeueReusableCell(withIdentifier: "accessoryDetailCell", for: indexPath) as! StarWarsWithAccessoryDetailTableViewCell
            
            cell.attributeLabel.textColor = data.attributeColor
            cell.attributeLabel.font = data.attributeFont
            
            cell.valueLabel.textColor = data.attributeValueColor
            cell.valueLabel.font = data.attributeValueFont
            
            cell.attributeLabel.text = attribute.rawValue
            cell.valueLabel.text = mappingPair.values.first!
            
            return cell
            
        }
        
    }
}
