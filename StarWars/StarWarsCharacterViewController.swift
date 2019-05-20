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
    
    
    override var facts: [[String : String]] {
        
        let heights: [Int] = allCharacters.compactMap { return Int($0.height)}
        let lowestHeight: Int? = heights.min()
        let highestHeight: Int? = heights.max()
        
        if let lowestHeight = lowestHeight, let highestHeight = highestHeight {
            
            let lowestHtName: String = self.allCharacters[heights.firstIndex(of: lowestHeight)!].name
            let highestHtName: String = self.allCharacters[heights.firstIndex(of: highestHeight)!].name
            return [["Smallest": lowestHtName], ["Largest": highestHtName]]
        }
        else {
            return super.facts
        }
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
