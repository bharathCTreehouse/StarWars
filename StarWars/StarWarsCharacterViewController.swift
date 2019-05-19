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
    let allCharacters: [Character]
    
    
    init(withDetailDataSource dataSource: StarWarsCharacterViewData, listOfCharacters: [Character]) {
        
        characterDetailDataSource = dataSource
        allCharacters = listOfCharacters
        super.init(withDetailDataSource: dataSource)
        addLengthUnitToggleNotificationObserver()
    }
    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    override func selectedPickerIndex(index: Int) {
        let selectedPerson: Character = allCharacters[index]
        characterDetailDataSource = StarWarsCharacterViewData(withCharacter: selectedPerson)
        detailDataSource = characterDetailDataSource
        super.selectedPickerIndex(index: index)
    }
    
    
    override var allNames: [String] {
        
        let names: [String] = allCharacters.compactMap({ (person: Character) -> String in
            
            return person.name
        })
        return names
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
