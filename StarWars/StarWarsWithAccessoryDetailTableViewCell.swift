//
//  StarWarsWithAccessoryDetailTableViewCell.swift
//  StarWars
//
//  Created by Bharath on 14/05/19.
//  Copyright © 2019 Bharath Chandrashekar. All rights reserved.
//

import UIKit

class StarWarsWithAccessoryDetailTableViewCell: UITableViewCell {
    
    @IBOutlet weak var attributeLabel: UILabel!
    @IBOutlet weak var valueLabel: UILabel!
    @IBOutlet weak var segmentControl: UISegmentedControl!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    
    @IBAction func segmentControlTapped(sender: UISegmentedControl) {
        
    }
    
    
    deinit {
        attributeLabel = nil
        valueLabel = nil
        segmentControl = nil
    }
    
}
