//
//  StarWarsTrimmedDataDisplayTableView.swift
//  StarWars
//
//  Created by Bharath on 25/05/19.
//  Copyright © 2019 Bharath Chandrashekar. All rights reserved.
//

import Foundation
import UIKit



class StarWarsCharacterTransporterTableView: UITableView {
    
    var trimmedVehicleDataSource: [StarWarsDetailDataSource] = []
    var trimmedStarshipDataSource: [StarWarsDetailDataSource] = []

    
    init(withTrimmedVehicleDataSource vehicleDS: [StarWarsDetailDataSource], trimmedstarshipDataSource starshipDS: [StarWarsDetailDataSource]) {
        
        trimmedVehicleDataSource = vehicleDS
        trimmedStarshipDataSource = starshipDS

        super.init(frame: .zero, style: .grouped)
        translatesAutoresizingMaskIntoConstraints = false
        
        self.sectionHeaderHeight = 50.0
        
        dataSource = self
        delegate = self
        
        backgroundColor = UIColor.init(red: 26.0/155.0, green: 32.0/155.0, blue: 36.0/155.0, alpha: 1.0)
    }
    
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    
    func addVehicleDetailDataSource(_ dataSource: StarWarsDetailDataSource) {
        
        self.trimmedVehicleDataSource.append(dataSource)
        self.insertRows(at: [IndexPath(row: trimmedVehicleDataSource.count-1, section: 0)], with: .automatic)
    }
    
    
    func addStarshipDetailDataSource(_ dataSource: StarWarsDetailDataSource) {
        
        self.trimmedStarshipDataSource.append(dataSource)
        self.insertRows(at: [IndexPath(row: trimmedStarshipDataSource.count-1, section: 1)], with: .automatic)

        
    }
}



extension StarWarsCharacterTransporterTableView: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    
   func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if section == 0 {
            return self.trimmedVehicleDataSource.count
        }
        else {
            return self.trimmedStarshipDataSource.count
        }
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        var cell: UITableViewCell? = tableView.dequeueReusableCell(withIdentifier: "cell")
        
        if cell == nil {
            cell = UITableViewCell(style: .subtitle, reuseIdentifier: "cell")
        }
        
        cell!.backgroundColor = UIColor.init(red: 26.0/155.0, green: 32.0/155.0, blue: 36.0/155.0, alpha: 1.0)
        
        
        if indexPath.section == 0 {
            
            //vehicles
            
            let dataSource: StarWarsDetailDataSource = self.trimmedVehicleDataSource[indexPath.row]
            
            cell!.textLabel?.font = dataSource.attributeValueFont
            cell!.detailTextLabel?.font = dataSource.attributeValueFont
            
            cell!.textLabel?.textColor = dataSource.attributeValueColor
            cell!.detailTextLabel?.textColor = dataSource.attributeValueColor

            
            let attrValueNameMapping: [StarWarsAttributeDisplay: String] = dataSource.attributeValueMappingPair.first!
            cell!.textLabel?.text = attrValueNameMapping.values.first!
            
            let attrValueManufacturingMapping: [StarWarsAttributeDisplay: String] = dataSource.attributeValueMappingPair.last!
            cell!.detailTextLabel?.text = attrValueManufacturingMapping.values.first!
            
        }
        else if indexPath.section == 1 {
            
            //starships
            
            let dataSource: StarWarsDetailDataSource = self.trimmedStarshipDataSource[indexPath.row]
            
            cell!.textLabel?.font = dataSource.attributeValueFont
            cell!.detailTextLabel?.font = dataSource.attributeValueFont
            
            cell!.textLabel?.textColor = dataSource.attributeValueColor
            cell!.detailTextLabel?.textColor = dataSource.attributeValueColor
            
            
            let attrValueNameMapping: [StarWarsAttributeDisplay: String] = dataSource.attributeValueMappingPair.first!
            cell!.textLabel?.text = attrValueNameMapping.values.first!
            
            let attrValueManufacturingMapping: [StarWarsAttributeDisplay: String] = dataSource.attributeValueMappingPair.last!
            cell!.detailTextLabel?.text = attrValueManufacturingMapping.values.first!
        }
        
        
        return cell!
        
    }
    
    
}



extension StarWarsCharacterTransporterTableView: UITableViewDelegate {
    
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
        
        let label: UILabel = UILabel()
        label.textAlignment = .center
        label.textColor = UIColor.lightText
        label.font = UIFont.boldSystemFont(ofSize: 25.0)
        
        if section == 0 {
            label.text = "Vehicles"
        }
        else {
            label.text = "Starships"
        }
        return label
    }
    
}
