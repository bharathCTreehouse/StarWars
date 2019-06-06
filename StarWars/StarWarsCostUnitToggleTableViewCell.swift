//
//  StarWarsCostUnitToggleTableViewCell.swift
//  StarWars
//
//  Created by Bharath on 16/05/19.
//  Copyright © 2019 Bharath Chandrashekar. All rights reserved.
//

import Foundation
import UIKit



class StarWarsCostUnitToggleTableViewCell: StarWarsUnitToggleTableViewCell {
    
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.accessoryDetailView.view!.backgroundColor = UIColor.init(red: 26.0/155.0, green: 32.0/155.0, blue: 36.0/155.0, alpha: 1.0)
        selectionStyle = .none

        
    }
    
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    
    override func updateWith(dataMapper attributeValueMapper: [StarWarsAttributeDisplay: String]) {
        
        super.updateWith(dataMapper: attributeValueMapper)
        validateSegmentControlState()
    }
    
    
    
    func updateSegmentControl(forCurrency currency: CurrencyType) {
        
        if currency == .credits {
            accessoryDetailView.unitToggleSegmentControl.selectedSegmentIndex = 0
        }
        else {
            accessoryDetailView.unitToggleSegmentControl.selectedSegmentIndex = 1
        }
    }
    
}



extension StarWarsCostUnitToggleTableViewCell {
    
    
    override func toggleUnitSegmentControl(withSelectedIndex index: Int) {
        
        super.toggleUnitSegmentControl(withSelectedIndex: index)
        NotificationCenter.default.post(name: NSNotification.Name("StarWarsCostUnitChanged"), object: nil)

    }
    
    
    override var segmentControlTitles: [String] {
        return ["Credits", "USD"]
    }
    
    
}

