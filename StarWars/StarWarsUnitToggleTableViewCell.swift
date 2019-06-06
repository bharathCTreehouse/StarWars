//
//  StarWarsUnitToggleTableViewCell.swift
//  StarWars
//
//  Created by Bharath on 04/06/19.
//  Copyright © 2019 Bharath Chandrashekar. All rights reserved.
//

import Foundation
import UIKit


class StarWarsUnitToggleTableViewCell: UITableViewCell {
    
    lazy var accessoryDetailView: StarWarsAccessoryDetailView = {
        return StarWarsAccessoryDetailView(withDelegate: self)
    }()
    
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        
        
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        
        self.contentView.addSubview(accessoryDetailView)
        
        accessoryDetailView.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor).isActive = true
        
        accessoryDetailView.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor).isActive = true
        
        accessoryDetailView.topAnchor.constraint(equalTo: self.contentView.topAnchor).isActive = true
        
        accessoryDetailView.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor).isActive = true
        
    }
    
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    
    
    func updateWith(dataMapper attributeValueMapper: [StarWarsAttributeDisplay: String]) {
        
        accessoryDetailView.attributeLabel.text = attributeValueMapper.keys.first!.rawValue
        accessoryDetailView.attributeValueLabel.text = attributeValueMapper.values.first!
    }
    
    
    func update(detailUIElement element: DetailUIElement, withFont font: UIFont, color: UIColor) {
        
        if element == .attribute {
            accessoryDetailView.attributeLabel.font = font
            accessoryDetailView.attributeLabel.textColor = color
        }
        else {
            accessoryDetailView.attributeValueLabel.font = font
            accessoryDetailView.attributeValueLabel.textColor = color
        }
    }
    
    
    
    func validateSegmentControlState() {
        
        if let _ = Double(accessoryDetailView.attributeLabel.text ?? "") {
            accessoryDetailView.unitToggleSegmentControl.isEnabled = false
            accessoryDetailView.unitToggleSegmentControl.alpha = 0.4
        }
        else {
            accessoryDetailView.unitToggleSegmentControl.isEnabled = true
            accessoryDetailView.unitToggleSegmentControl.alpha = 1.0
        }
    }
    
}


extension StarWarsUnitToggleTableViewCell: StarWarsAccessoryButtonProtocol {
    
    
    @objc func toggleUnitSegmentControl(withSelectedIndex index: Int) {
        if index < 0 {
            return
        }
    }
    
    @objc var segmentControlTitles: [String] {
        return ["Unit 1", "Unit 2"]
    }
    
}

