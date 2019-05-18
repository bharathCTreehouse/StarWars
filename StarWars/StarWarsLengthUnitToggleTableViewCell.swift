//
//  StarWarsLengthUnitToggleTableViewCell.swift
//  StarWars
//
//  Created by Bharath on 16/05/19.
//  Copyright © 2019 Bharath Chandrashekar. All rights reserved.
//

import Foundation
import UIKit


class StarWarsLengthUnitToggleTableViewCell: UITableViewCell {
    
    
    lazy private var accessoryDetailView: StarWarsAccessoryDetailView = {
        return StarWarsAccessoryDetailView(withDelegate: self)
    }()
    
    
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        
        
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        

        self.contentView.addSubview(accessoryDetailView)
        
        accessoryDetailView.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor).isActive = true
        
        accessoryDetailView.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor).isActive = true
        
        accessoryDetailView.topAnchor.constraint(equalTo: self.contentView.topAnchor).isActive = true
        
        accessoryDetailView.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor).isActive = true
        
        self.accessoryDetailView.view!.backgroundColor = UIColor.init(red: 26.0/155.0, green: 32.0/155.0, blue: 36.0/155.0, alpha: 1.0)
        
        self.accessoryDetailView.updateSegmentControlTitles(withList: segmentControlTitles)
        
    }
    
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    
    func updateWith(dataMapper attributeValueMapper: [StarWarsAttributeDisplay: String]) {
        
        accessoryDetailView.attributeLabel.text = attributeValueMapper.keys.first!.rawValue
        accessoryDetailView.attributeValueLabel.text = attributeValueMapper.values.first!
    }
    
    
    func updateWith(dataSource data: StarWarsDetailDataSource) {
        
        accessoryDetailView.attributeLabel.textColor = data.attributeColor
        accessoryDetailView.attributeLabel.font = data.attributeFont
        
        accessoryDetailView.attributeValueLabel.textColor = data.attributeValueColor
        accessoryDetailView.attributeValueLabel.font = data.attributeValueFont
        
        
        let baseSource: StarWarsViewData? = data as? StarWarsViewData
        if baseSource?.currentLengthUnit == .metres {
            accessoryDetailView.unitToggleSegmentControl.selectedSegmentIndex = 0
        }
        else {
            accessoryDetailView.unitToggleSegmentControl.selectedSegmentIndex = 1

        }
    }
    
}



extension StarWarsLengthUnitToggleTableViewCell: StarWarsAccessoryButtonProtocol {
    
    
    func toggleUnitSegmentControl(withSelectedIndex index: Int) {
        
        NotificationCenter.default.post(name: NSNotification.Name("StarWarsLengthUnitChanged"), object: nil)
    }
    
    var segmentControlTitles: [String] {
        return ["Metric", "English"]
    }

}
