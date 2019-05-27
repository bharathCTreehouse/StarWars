//
//  UITableViewCellUtilities.swift
//  StarWars
//
//  Created by Bharath on 28/05/19.
//  Copyright © 2019 Bharath Chandrashekar. All rights reserved.
//

import Foundation
import UIKit


extension UITableViewCell {
    
    
    func removeSeparator() {
        
        layoutMargins = .zero
        separatorInset = UIEdgeInsets.init(top: 0.0, left: 0.0, bottom: 0.0, right: 9999.0)
    }
    
    
    func addDefaultSeparator() {
        layoutMargins = UIEdgeInsets.init()
        separatorInset = UIEdgeInsets.init()
        
    }
    
}
