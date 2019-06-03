//
//  ViewControllerWithAlertControllerUtilities.swift
//  StarWars
//
//  Created by Bharath on 30/05/19.
//  Copyright © 2019 Bharath Chandrashekar. All rights reserved.
//

import Foundation
import UIKit


extension UIViewController {
    
    func showAlertController(forError error: Error, defaultStyleButtonTitle buttonTitle: String, alertControllerTitle alertTitle: String?) {
        
        var errorMessage: String? = nil
        let alertActionData: AlertControllerActionData = AlertControllerActionData(actionTitle: buttonTitle, actionStyle: .default)
        
        if let starWarsApiError = error as? StarWarsError {
            errorMessage = starWarsApiError.starWarsErrorDescription()
        }
        else {
            errorMessage = error.localizedDescription
        }
        
        let alertControllerData: AlertControllerData = AlertControllerData(title: alertTitle, message: errorMessage, alertActions: [alertActionData], textFieldData: nil)
        
        let alertController: UIAlertController = AlertViewController.alertController(withAlertControllerData: alertControllerData, completionHandler:nil)
        
        self.present(alertController, animated: true, completion: nil)
        
    }
    
    
    
    func showAlertController(withAlertTitle title: String?, alertMessage message: String?, defaultStyleButtonTitle buttonTitle: String) {
        
        
        let alertActionData: AlertControllerActionData = AlertControllerActionData(actionTitle: buttonTitle, actionStyle: .default)
        
        let alertControllerData: AlertControllerData = AlertControllerData(title: title, message: message, alertActions: [alertActionData], textFieldData: nil)
        
        let alertController: UIAlertController = AlertViewController.alertController(withAlertControllerData: alertControllerData, completionHandler:nil)
        
        self.present(alertController, animated: true, completion: nil)
        
    }
    
    
}

