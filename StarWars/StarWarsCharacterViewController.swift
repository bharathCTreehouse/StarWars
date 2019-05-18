//
//  StarWarsCharacterViewController.swift
//  StarWars
//
//  Created by Bharath on 15/05/19.
//  Copyright © 2019 Bharath Chandrashekar. All rights reserved.
//

import Foundation
import UIKit


class StarWarsCharacterViewController: StarWarsDetailViewController {
    
    var characterDetailDataSource: StarWarsCharacterViewData
    
    
    override init(withDetailDataSource dataSource: StarWarsDetailDataSource) {
        
        characterDetailDataSource = dataSource as! StarWarsCharacterViewData
        super.init(withDetailDataSource: dataSource)
        addLengthUnitToggleNotificationObserver()
    }
    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
}



extension StarWarsCharacterViewController {
    
    func addLengthUnitToggleNotificationObserver() {
        
        NotificationCenter.default.addObserver(self, selector: #selector(lengthUnitToggleTriggered(withNotification:)), name: NSNotification.Name(rawValue: "StarWarsLengthUnitChanged"), object: nil)
        
    }
    
    
    @objc func lengthUnitToggleTriggered(withNotification notification: Notification) {
        
        characterDetailDataSource.toggleLengthUnit()
        reloadDetailTableView(atIndexPath: IndexPath(row: 2, section: 0))
    }
}
