//
//  SingleImageTableViewCell.swift
//  StarWars
//
//  Created by Bharath Chandrashekar on 29/04/19.
//  Copyright © 2019 Bharath Chandrashekar. All rights reserved.
//

import UIKit

class SingleImageTableViewCell: UITableViewCell {
    
    @IBOutlet private var singleImageView: UIImageView!
    @IBOutlet private var imageTitleDescriptionLabel: UILabel!


    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    
    func update(withImage image: UIImage) {
        singleImageView.image = image
        singleImageView.sizeToFit()
    }
    
    
    func update(withImageDescriptionTitle title: NSAttributedString) {
        imageTitleDescriptionLabel.attributedText = title
    }
    
    
    func update(withBackgroundColour colour: UIColor) {
        self.backgroundColor = colour
    }

   
    
    deinit {
        singleImageView = nil
        imageTitleDescriptionLabel = nil
    }
    
}
