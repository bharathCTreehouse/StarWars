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
    
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        factsView.update(withFactsDataSource: StarWarsFactsData(withSizeList: allCharacters))
        setupNavigationBarButtonItem()
        updateNavigationTitle(with: allCharacters.first?.name ?? "")
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
        updateNavigationTitle(with: selectedPerson.name)
        super.selectedPickerIndex(index: index)
    }
    
    
    override var allNames: [String] {
        
        let names: [String] = allCharacters.compactMap({ (person: Character) -> String in
            
            return person.name
        })
        return names
    }
    
    
    
    func setupNavigationBarButtonItem() {
        
        let infoButton: UIButton = UIButton(type: .infoDark)
        infoButton.addTarget(self, action: #selector(infoButtonTapped(_:)), for: .touchUpInside)
        
        let barbuttonItem: UIBarButtonItem = UIBarButtonItem(customView: infoButton)
        self.navigationItem.rightBarButtonItem = barbuttonItem
        
    }
    
    
    @objc func infoButtonTapped(_ sender: UIButton) {
        
        
        let selectedPerson: Character? =  (detailTableView.tableViewDataSource.data as? StarWarsCharacterViewData)?.starWarsCharacter
        
        if let selectedPerson = selectedPerson {
            
            let trimmedTransporterVC: StarWarsCharacterTransporterViewController = StarWarsCharacterTransporterViewController(withPerson: selectedPerson)
            
            let navController: UINavigationController = UINavigationController(rootViewController: trimmedTransporterVC)
            self.present(navController, animated: true, completion: nil)

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
            
            apiClient.fetchAllCharacters(forRequest: urlReq, withCompletionHandler:  { [unowned self] (people: [Character], nextUrlState: StarWarsNextSetUrlReceiverType, error: Error?) -> Void in
                
                self.pickerView.toggleAdditionalViewToInProgressState(false)
                
                switch nextUrlState {
                    case let .update(withUrlString:nextUrlStr):                 self.nextSetUrlString = nextUrlStr
                    default: break

                }
                
                if error == nil {
                    
                    if people.isEmpty == false {
                        
                        self.allCharacters.append(contentsOf: people)
                        self.pickerView.updateTitleList(withList: self.allNames)
                        self.fetchHomeNameOfAllCharacters()
                        
                        //Recalculate facts and update
                        self.factsView.update(withFactsDataSource: StarWarsFactsData(withSizeList: self.allCharacters))
                        
                    }
                }
                else {
                    //Show alert.
                    if error!.isUrlDataTaskCancelled == false{
                        self.showAlert(forError: error!)
                    }
                }
                
            })
        }

        
    }
    
}




