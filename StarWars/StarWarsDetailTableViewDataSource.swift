//
//  StarWarsDetailTableViewDataSource.swift
//  StarWars
//
//  Created by Bharath on 14/05/19.
//  Copyright © 2019 Bharath Chandrashekar. All rights reserved.
//

import Foundation
import UIKit


class StarWarsDetailTableViewDataSource: NSObject, UITableViewDataSource {
    
    private(set) var data: StarWarsDetailDataSource

    
    required init(withDetailDataSource dataSource: StarWarsDetailDataSource) {
        
        data = dataSource
    }
    
    
    func updateWithDataSource(_ dataSource:StarWarsDetailDataSource) {
        data = dataSource
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return data.attributeValueMappingPair.count
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let mappingPair: [StarWarsAttributeDisplay: String] = data.attributeValueMappingPair[indexPath.row]
        let attribute: StarWarsAttributeDisplay = mappingPair.keys.first!
        
        let isLastRow: Bool = (indexPath.row == data.attributeValueMappingPair.count-1) ? true : false
        
        if attribute.canBeConvertedToAlternateUnit == false {
            
            let cell: StarWarsDetailTableViewCell = tableView.dequeueReusableCell(withIdentifier: "detailCell", for: indexPath) as! StarWarsDetailTableViewCell
            
            cell.attributeLabel.textColor = data.textColor(forElement: .attribute)
            cell.attributeLabel.font = data.font(forElement: .attribute)
            
            cell.valueLabel.textColor = data.textColor(forElement: .value)
            cell.valueLabel.font = data.font(forElement: .value)
            
            cell.attributeLabel.text = attribute.rawValue
            cell.valueLabel.text = mappingPair.values.first!
            
            
            if isLastRow == true {
                cell.removeSeparator()
            }
            else {
                cell.addDefaultSeparator()
            }
            
            return cell
        }
        else {
            
            var cell: UITableViewCell
            
            if attribute == .length || attribute == .height {
                
                cell = tableView.dequeueReusableCell(withIdentifier: "lengthToggleCell", for: indexPath)
                
                let lengthUnitCell: StarWarsLengthUnitToggleTableViewCell = (cell as! StarWarsLengthUnitToggleTableViewCell)
                
                
                lengthUnitCell.updateWith(dataMapper: mappingPair)
                lengthUnitCell.updateSegmentControl(forUnit: data.unitForLengthOrHeight)
                
                lengthUnitCell.update(detailUIElement: .attribute, withFont: data.font(forElement: .attribute), color: data.textColor(forElement: .attribute))
                
                lengthUnitCell.update(detailUIElement: .value, withFont: data.font(forElement: .value), color: data.textColor(forElement: .value))
                
            }
            else {
                
                //Cost
                
                cell = tableView.dequeueReusableCell(withIdentifier: "costToggleCell", for: indexPath)
                
                let costUnitCell: StarWarsCostUnitToggleTableViewCell = (cell as! StarWarsCostUnitToggleTableViewCell)
                
                
                costUnitCell.updateWith(dataMapper: mappingPair)
                if let costUnitDataSource = data as? StarWarsTransporterDetailDataSource {
                    costUnitCell.updateSegmentControl(forCurrency: costUnitDataSource.unitForCost)
                }
                
                costUnitCell.update(detailUIElement: .attribute, withFont: data.font(forElement: .attribute), color: data.textColor(forElement: .attribute))
                
                costUnitCell.update(detailUIElement: .value, withFont: data.font(forElement: .value), color: data.textColor(forElement: .value))
                
            }
            
            
            if isLastRow == true {
                cell.removeSeparator()
            }
            else {
                cell.addDefaultSeparator()
            }
            
            return cell
            
        }
        
    }
    
}

