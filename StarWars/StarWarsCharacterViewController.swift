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
    
    var allCharacters: [Character]
    var characterHomeOpQueue: OperationQueue? = OperationQueue.init()

    
    
    init(withListOfCharacters characters: [Character], nextSetUrlString urlString: String? = nil) {
        
        allCharacters = characters
        super.init(withDetailDataSource: StarWarsCharacterViewData(withCharacter: characters.first!), nextSetUrlString: urlString)
        addLengthUnitToggleNotificationObserver()
    }
    
   
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    
    override func viewDidAppear(_ animated: Bool) {
        
        super.viewDidAppear(animated)
        fetchHomeNameOfAllCharacters()
    }
    
    
    override func viewDidDisappear(_ animated: Bool) {
        
        super.viewDidDisappear(animated)
        characterHomeOpQueue?.cancelAllOperations()
    }
    
    
    override func selectedPickerIndex(index: Int) {
        let selectedPerson: Character = allCharacters[index]
        let newCharacterViewData: StarWarsCharacterViewData  = StarWarsCharacterViewData(withCharacter: selectedPerson)
        detailTableView.updateDataSource(newCharacterViewData)
        super.selectedPickerIndex(index: index)
    }
    
    
    override var allNames: [String] {
        
        let names: [String] = allCharacters.compactMap({ (person: Character) -> String in
            
            return person.name
        })
        return names
    }
    
    
    override var facts: [[String : String]] {
        
        let heights: [Double] = allCharacters.compactMap { return Double($0.height)}
        let lowestHeight: Double? = heights.min()
        let highestHeight: Double? = heights.max()
        
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
        characterHomeOpQueue?.cancelAllOperations()
        characterHomeOpQueue = nil
    }
    
}



extension StarWarsCharacterViewController {
    
    func addLengthUnitToggleNotificationObserver() {
        
        NotificationCenter.default.addObserver(self, selector: #selector(lengthUnitToggleTriggered(withNotification:)), name: NSNotification.Name(rawValue: "StarWarsLengthUnitChanged"), object: nil)
        
    }
    
    
    @objc func lengthUnitToggleTriggered(withNotification notification: Notification) {
        
        let viewData: StarWarsCharacterViewData? = detailTableView.tableViewDataSource.data as? StarWarsCharacterViewData
        viewData?.toggleLengthUnit()
        reloadDetailTableView(atIndexPath: IndexPath(row: 2, section: 0))
    }
}


extension StarWarsCharacterViewController: FetchCharacterHomeOperationCompletionProtocol {
    
    
    func fetchHomeNameOfAllCharacters() {
        
        let homelessCharacters: [Character] = allCharacters.filter( { (person: Character) -> Bool in
            return (person.home == nil)
        })
        
        if homelessCharacters.isEmpty == false {
            
            let characterOps: [StarWarsFetchCharacterHomeOperation] = homelessCharacters.compactMap ( { StarWarsFetchCharacterHomeOperation(withPerson: $0, delegate: self) } )
            
            if characterOps.isEmpty == false {
                
                characterHomeOpQueue?.addOperations(characterOps, waitUntilFinished: false)
            }
        }
    }
    
    
    
    func homeFetchedForCharacter(withName name: String) {
        
        let currentPersonName: String? = (detailTableView.tableViewDataSource.data as? StarWarsCharacterViewData)?.starWarsCharacter.name
        
        if let currentPersonName = currentPersonName {
            if name == currentPersonName {
                reloadDetailTableView(atIndexPath: IndexPath(row: 1, section: 0))
            }
        }
    }
    
}



extension StarWarsCharacterViewController {
    
    //Fetch more characters. Update the next URL property in the base VC, add the newly got character objects into the allCharacters array, and then again call home character API in the background using operations.
    
    override func loadMoreContent() {
        
        super.loadMoreContent()
        
        if let nextUrlString = nextSetUrlString,  let url = URL(string: nextUrlString) {
            
            pickerView.toggleAdditionalViewToInProgressState(true)
            
            let apiClient: StarWarsAPIClient = StarWarsAPIClient()
            let urlReq: URLRequest = URLRequest(url: url)
            
            apiClient.fetchAllCharacters(forRequest: urlReq, withCompletionHandler:  { [unowned self] (people: [Character], nextUrlStr: String?, error: StarWarsError?) -> Void in
                
                self.pickerView.toggleAdditionalViewToInProgressState(false)

                self.nextSetUrlString = nextUrlStr
                
                if error == nil {
                    
                    if people.isEmpty == false {
                        
                        self.allCharacters.append(contentsOf: people)
                        self.pickerView.updateTitleList(withList: self.allNames)
                        self.fetchHomeNameOfAllCharacters()
                        
                        //Recalculate facts and update
                        self.factsView.update(withFactsDataSource: self)
                        
                    }
                }
                else {
                    //Show alert.
                }
                
            })
        }

        
    }
    
}
