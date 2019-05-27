//
//  StarWarsTransporterViewController.swift
//  StarWars
//
//  Created by Bharath on 15/05/19.
//  Copyright © 2019 Bharath Chandrashekar. All rights reserved.
//

import Foundation
import UIKit


class StarWarsTransporterViewController: StarWarsDetailViewController {
    
    var allTransporters: [Transporter]
    
   
    init(withListOfTransporters transporters: [Transporter], nextSetUrlString urlString: String? = nil) {
        
        allTransporters = transporters
        super.init(withDetailDataSource: StarWarsTransporterViewData(withTransporter: transporters.first!), nextSetUrlString: urlString)
        addLengthUnitToggleNotificationObserver()
        addCostUnitToggleNotificationObserver()
    }
    
    
    required init?(coder aDecoder: NSCoder) {
        allTransporters = []
        super.init(coder: aDecoder)
    }
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        factsView.update(withFactsDataSource: StarWarsFactsData(withSizeList: allTransporters))
        updateNavigationTitle(with: allTransporters.first?.name ?? "")
    }
    
    
    override func selectedPickerIndex(index: Int) {
        let selectedTransporter: Transporter = allTransporters[index]
        let newTransporterViewData: StarWarsTransporterViewData  = StarWarsTransporterViewData(withTransporter: selectedTransporter)
        detailTableView.updateDataSource(newTransporterViewData)
        updateNavigationTitle(with: selectedTransporter.name)
        super.selectedPickerIndex(index: index)
    }
    
    
    override var allNames: [String] {
        
        let names: [String] = allTransporters.compactMap({ (transporter: Transporter) -> String in
            return transporter.name
        })
        return names
    }
    
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
}


extension StarWarsTransporterViewController {
    
    func addLengthUnitToggleNotificationObserver() {
        
        NotificationCenter.default.addObserver(self, selector: #selector(lengthUnitToggleTriggered(withNotification:)), name: NSNotification.Name(rawValue: "StarWarsLengthUnitChanged"), object: nil)
        
    }
    
    
    @objc func lengthUnitToggleTriggered(withNotification notification: Notification) {
        
        let viewData: StarWarsTransporterViewData? = detailTableView.tableViewDataSource.data as? StarWarsTransporterViewData
        viewData?.toggleLengthUnit()
        reloadDetailTableView(atIndexPath: IndexPath(row: 2, section: 0))

    }
}



extension StarWarsTransporterViewController {
    
    func addCostUnitToggleNotificationObserver() {
        
        NotificationCenter.default.addObserver(self, selector: #selector(costUnitToggleTriggered(withNotification:)), name: NSNotification.Name(rawValue: "StarWarsCostUnitChanged"), object: nil)
        
    }
    
    
    @objc func costUnitToggleTriggered(withNotification notification: Notification) {
        
        print("costUnitToggleTriggered--Transporter")

    }
    
}




extension StarWarsTransporterViewController {
    
    
    override func loadMoreContent() {
        
        super.loadMoreContent()
        
        if let nextUrlString = nextSetUrlString,  let url = URL(string: nextUrlString) {
            
            pickerView.toggleAdditionalViewToInProgressState(true)
            
            let apiClient: StarWarsAPIClient = StarWarsAPIClient()
            let urlReq: URLRequest = URLRequest(url: url)
            
            apiClient.fetchAllTransporters(forRequest: urlReq, withCompletionHandler:  { [unowned self] (movables: [Transporter], nextUrlStr: String?, error: Error?) -> Void in
                
                self.pickerView.toggleAdditionalViewToInProgressState(false)
                
                self.nextSetUrlString = nextUrlStr
                
                if error == nil {
                    
                    if movables.isEmpty == false {
                        
                        self.allTransporters.append(contentsOf: movables)
                        self.pickerView.updateTitleList(withList: self.allNames)
                        
                        //Recalculate facts and update
                        self.factsView.update(withFactsDataSource: StarWarsFactsData(withSizeList: self.allTransporters))

                        
                    }
                }
                else {
                    //Show alert.
                }
                
            })
        }
        
        
    }
}

