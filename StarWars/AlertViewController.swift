//
//  AlertViewController.swift
//  StarWars
//
//  Created by Bharath on 29/05/19.
//  Copyright © 2019 Bharath Chandrashekar. All rights reserved.
//

import Foundation
import UIKit


class AlertViewController {
    
    
    static func alertController(withAlertControllerData data: AlertControllerData, completionHandler: ((Int, [String]?) -> Void)?) -> UIAlertController {
        
        
        let alertController = UIAlertController(title: data.title, message: data.message, preferredStyle: .alert)
        
        for actionData in data.alertActions {
            
            let action: UIAlertAction = UIAlertAction.init(title: actionData.actionTitle, style: actionData.actionStyle, handler: {  (alertAct: UIAlertAction) -> Void in
                
                if let allTextFields = alertController.textFields {
                    
                    var textFieldTexts: [String] = []
                    for textField in allTextFields {
                        textFieldTexts.append(textField.text ?? "")
                    }
                    completionHandler?(alertController.actions.firstIndex(of: alertAct)!, textFieldTexts)
                }
                else {
                    completionHandler?(alertController.actions.firstIndex(of: alertAct)!, nil)
                }
            })
            
            alertController.addAction(action)
        }
        
        
        if let listOfTextFieldInfo =  data.textFieldData {
            
            for textFieldInfo in listOfTextFieldInfo {
                
                alertController.addTextField(configurationHandler: { txtField in
                    
                    txtField.placeholder = textFieldInfo.placeHolderText
                    txtField.text = textFieldInfo.defaultText
                    txtField.borderStyle = textFieldInfo.borderType
                    txtField.keyboardType = textFieldInfo.keypadType
                })
            }
        }
        
        return alertController
    }
    
}
