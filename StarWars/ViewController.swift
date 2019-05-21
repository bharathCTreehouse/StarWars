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
        starWarsIntroTableView!.delegate = self
        view.addSubview(starWarsIntroTableView!)
        starWarsIntroTableView!.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        starWarsIntroTableView!.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        starWarsIntroTableView!.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        starWarsIntroTableView!.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        
        self.title = "Star Wars"
        
    }
    
    
    deinit {
        starWarsIntroTableView = nil
    }
}


extension ViewController: UITableViewDelegate {
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if indexPath.row == 0 {
            
            let characterEndpoint: StarWars = StarWars.character(.all)
            let characterReq: URLRequest? = characterEndpoint.urlRequest
            
            apiClient.fetchAllCharacters(forRequest: characterReq!, withCompletionHandler: { (people: [Character], error: StarWarsError?) -> Void in
                
                if error == nil {
                    
                    let detailVC: StarWarsCharacterViewController = StarWarsCharacterViewController(withListOfCharacters: people)
                    self.navigationController?.pushViewController(detailVC, animated: true)
                    
                }
                else {
                    print("Error: \(error!)")
                }
            })
            
        }
        else {
            
            var transportRequest: URLRequest
            
            if indexPath.row == 1 {
                let vehicleEndpoint: StarWars = StarWars.vehicle(.all)
                transportRequest = vehicleEndpoint.urlRequest!
            }
            else {
                let starshipEndpoint: StarWars = StarWars.starship(.all)
                transportRequest = starshipEndpoint.urlRequest!
            }
            
            
            apiClient.fetchAllTransporters(forRequest: transportRequest, withCompletionHandler: { (movables: [Transporter], error: StarWarsError?) -> Void in
                
                if error == nil {
                    
                    let detailVC: StarWarsTransporterViewController = StarWarsTransporterViewController(withListOfTransporters: movables)
                    self.navigationController?.pushViewController(detailVC, animated: true)
                    
                }
                else {
                    print("Error: \(error!)")
                }
                
            })
            
        }
        
    }
}

