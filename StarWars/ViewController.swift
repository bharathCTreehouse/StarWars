//
//  ViewController.swift
//  StarWars
//
//  Created by Bharath Chandrashekar on 28/04/19.
//  Copyright © 2019 Bharath Chandrashekar. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    var starWarsIntroTableView: SingleImageDisplayableTableView? = nil
    let apiClient: StarWarsAPIClient = StarWarsAPIClient()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let characterData: StarWarsIntroductionData = StarWarsIntroductionData(imageName: "Character", componentName: "Characters")
        let characterViewData: StarWarsIntroductionViewData = StarWarsIntroductionViewData(withStarWarsIntroData: characterData)
        
        let vehicleData: StarWarsIntroductionData = StarWarsIntroductionData(imageName: "Vehicle", componentName: "Vehicles")
        let vehicleViewData: StarWarsIntroductionViewData = StarWarsIntroductionViewData(withStarWarsIntroData: vehicleData)
        
        let starShipsData: StarWarsIntroductionData = StarWarsIntroductionData(imageName: "Starship", componentName: "Starships")
        let starShipsViewData: StarWarsIntroductionViewData = StarWarsIntroductionViewData(withStarWarsIntroData: starShipsData)
        
        starWarsIntroTableView = SingleImageDisplayableTableView(withImages: [characterViewData, vehicleViewData, starShipsViewData])
        view.addSubview(starWarsIntroTableView!)
        starWarsIntroTableView!.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        starWarsIntroTableView!.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        starWarsIntroTableView!.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        starWarsIntroTableView!.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        
        self.title = "Star Wars"
        
        let characterEndpoint: StarWars = StarWars.character(.all)
        let characterReq: URLRequest? = characterEndpoint.urlRequest
        
        apiClient.fetchAllCharacters(forRequest: characterReq!, withCompletionHandler: { (people: [Character], error: StarWarsError?) -> Void in
            
            if error == nil {
                print("Count: \(people.count)")
                print("PEOPLES: \(people)")
            }
            else {
                print("Error: \(error!)")
            }
        })
        
    }
    
    
    deinit {
        starWarsIntroTableView = nil
    }


}

