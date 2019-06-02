//
//  AlertControllerTextFieldData.swift
//  StarWars
//
//  Created by Bharath on 31/05/19.
//  Copyright © 2019 Bharath Chandrashekar. All rights reserved.
//

import Foundation
import UIKit


struct AlertControllerTextFieldData {
    
    var placeHolderText: String?
    let borderType: UITextField.BorderStyle
    var defaultText: String?
    var keypadType: UIKeyboardType = .default
}
