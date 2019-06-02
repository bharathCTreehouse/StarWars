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
        
    
        self.navigationItem.title = "Star Wars"
        
        configureNavigationBarButtonItem()
        
    }
    
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        animateProgressIndicator(false)
    }
    
    
    
    func configureNavigationBarButtonItem() {
        
        let activityView: UIActivityIndicatorView = UIActivityIndicatorView(style: .gray)
        activityView.hidesWhenStopped = true
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(customView: activityView)
    }
    
    
    deinit {
        starWarsIntroTableView = nil
    }
}


extension ViewController: UITableViewDelegate {
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        
        apiClient.cancelAllPendingDataTasks()
        animateProgressIndicator(true)


        tableView.deselectRow(at: indexPath, animated: true)
        
        if indexPath.row == 0 {
            
            let characterEndpoint: StarWars = StarWars.character(.all)
            let characterReq: URLRequest? = characterEndpoint.urlRequest
            

            apiClient.fetchAllCharacters(forRequest: characterReq!, withCompletionHandler: { [unowned self] (people: [Character], nextUrlState: StarWarsNextSetUrlReceiverType, error: Error?) -> Void in
                
                if error == nil {
                    
                    let detailVC: StarWarsCharacterViewController = StarWarsCharacterViewController(withListOfCharacters: people, nextSetUrlString: nextUrlState.urlString)
                    self.navigationController?.pushViewController(detailVC, animated: true)
                    
                }
                else {
                    if error!.isUrlDataTaskCancelled == false {
                        self.showAlert(forError: error!)
                        self.animateProgressIndicator(false)
                    }

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
            
            apiClient.fetchAllTransporters(forRequest: transportRequest, withCompletionHandler: { [unowned self] (movables: [Transporter], nextUrlState: StarWarsNextSetUrlReceiverType, error: Error?) -> Void in
                
                if error == nil {
                    
                    let detailVC: StarWarsTransporterViewController = StarWarsTransporterViewController(withListOfTransporters: movables, nextSetUrlString: nextUrlState.urlString)
                    self.navigationController?.pushViewController(detailVC, animated: true)
                    
                }
                else {
                    if error!.isUrlDataTaskCancelled == false {
                        self.showAlert(forError: error!)
                        self.animateProgressIndicator(false)
                    }
                }
                
                
            })
            
        }
        
    }
}



extension ViewController {
    
    
    func animateProgressIndicator(_ animate: Bool) {
        
        let activityView: UIActivityIndicatorView? =  navigationItem.rightBarButtonItem?.customView as? UIActivityIndicatorView
        
        if let activityView = activityView {
            if animate == true {
                activityView.startAnimating()
            }
            else {
                activityView.stopAnimating()
            }
        }
        
    }
    
}




extension ViewController {
    
    
    func showAlert(forError error: Error) {
        
        showAlertController(forError: error, defaultStyleButtonTitle: "OK", alertControllerTitle: "Error")
        
    }
    
}

