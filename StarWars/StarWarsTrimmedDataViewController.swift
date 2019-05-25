//
//  StarWarsTrimmedDataViewController.swift
//  StarWars
//
//  Created by Bharath on 25/05/19.
//  Copyright © 2019 Bharath Chandrashekar. All rights reserved.
//

import Foundation
import UIKit



class StarWarsTrimmedDataViewController: UIViewController {
    
    let trimmedTableView: StarWarsTrimmedDataDisplayTableView = StarWarsTrimmedDataDisplayTableView(withTrimmedVehicleDataSource: [], trimmedstarshipDataSource: [])
    
    let person: Character
    let characterTransporterOperationQueue: OperationQueue = OperationQueue.init()
    
    
    init(withPerson person: Character) {
        self.person = person
        super.init(nibName: nil, bundle: nil)
    }
    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    override func loadView() {
        
        self.view = UIView()
        
        view.addSubview(trimmedTableView)
        
        trimmedTableView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        trimmedTableView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        trimmedTableView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        trimmedTableView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
    }
    
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        fetchVehiclesOfSelectedCharacter()
        fetchStarshipsOfSelectedCharacter()
    }
    
}




extension StarWarsTrimmedDataViewController {
    
    func fetchVehiclesOfSelectedCharacter() {
        
        let vehicleUrlStrings: [String] = self.person.vehicles
        
        if vehicleUrlStrings.isEmpty == false {
            
            let vehicleUrls: [URL] = vehicleUrlStrings.compactMap {
                return URL(string:$0)
            }
            
            if vehicleUrls.isEmpty == false {
                
                let vehicleOperations: [StarWarsFetchCharacterTransportersOperation] = vehicleUrls.compactMap ( {
                    
                    return StarWarsFetchCharacterTransportersOperation(withTransporterType: .vehicle, forPerson: person, withURL: $0, withCompletionDelegate: self)
                })
                
                if vehicleOperations.isEmpty == false {
                    characterTransporterOperationQueue.addOperations(vehicleOperations, waitUntilFinished: false)
                }
            }
        }
        
    }
    
    
    func fetchStarshipsOfSelectedCharacter() {
        
        let starshipUrlStrings: [String] = self.person.starships
        
        if starshipUrlStrings.isEmpty == false {
            
            let starshipUrls: [URL] = starshipUrlStrings.compactMap {
                return URL(string:$0)
            }
            
            if starshipUrls.isEmpty == false {
                
                let starshipOperations: [StarWarsFetchCharacterTransportersOperation] = starshipUrls.compactMap ( {
                    
                    return StarWarsFetchCharacterTransportersOperation(withTransporterType: .starship, forPerson: person, withURL: $0, withCompletionDelegate: self)
                })
                
                if starshipOperations.isEmpty == false {
                    characterTransporterOperationQueue.addOperations(starshipOperations, waitUntilFinished: false)
                }
            }
        }
    }
    
}



extension StarWarsTrimmedDataViewController: StarWarsFetchCharacterTransporterCompletionProtocol {
    
    
    func transporterFetched(_ transporter: Transporter, ofType type: TransporterType) {
        
        let viewModel: StarWarsTrimmedTransporterViewData = StarWarsTrimmedTransporterViewData(withTransporter: transporter)
        
        if type == .vehicle {
            trimmedTableView.addVehicleDetailDataSource(viewModel)
        }
        else if type == .starship {
            trimmedTableView.addStarshipDetailDataSource(viewModel)
        }
    }
    
}
