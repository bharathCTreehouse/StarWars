//
//  AlertControllerData.swift
//  StarWars
//
//  Created by Bharath on 29/05/19.
//  Copyright © 2019 Bharath Chandrashekar. All rights reserved.
//

import Foundation


struct AlertControllerData {
    var title: String?
    var message: String?
    var alertActions: [AlertControllerActionData]
    var textFieldData: [AlertControllerTextFieldData]?
}
