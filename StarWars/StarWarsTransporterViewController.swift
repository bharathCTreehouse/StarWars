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
    
    var transporterDetailDataSource: StarWarsTransporterViewData
    var allTransporters: [Transporter]
    
   
    init(withDetailDataSource dataSource: StarWarsTransporterViewData, listOfTransporters: [Transporter]) {
        
        transporterDetailDataSource = dataSource
        allTransporters = listOfTransporters
        super.init(withDetailDataSource: dataSource)
        addLengthUnitToggleNotificationObserver()
        addCostUnitToggleNotificationObserver()
    }
    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    override func selectedPickerIndex(index: Int) {
        let selectedTransporter: Transporter = allTransporters[index]
        transporterDetailDataSource = StarWarsTransporterViewData(withTransporter: selectedTransporter)
        detailDataSource = transporterDetailDataSource
        super.selectedPickerIndex(index: index)
    }
    
    
    override var allNames: [String] {
        
        let names: [String] = allTransporters.compactMap({ (transporter: Transporter) -> String in
            return transporter.name
        })
        return names
    }
    
    
    override var facts: [[String : String]] {
        
        let heights: [Int] = allTransporters.compactMap { return Int($0.length)}
        let lowestHeight: Int? = heights.min()
        let highestHeight: Int? = heights.max()
        
        if let lowestHeight = lowestHeight, let highestHeight = highestHeight {
            
            let lowestHtName: String = self.allTransporters[heights.firstIndex(of: lowestHeight)!].name
            let highestHtName: String = self.allTransporters[heights.firstIndex(of: highestHeight)!].name
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


extension StarWarsTransporterViewController {
    
    func addLengthUnitToggleNotificationObserver() {
        
        NotificationCenter.default.addObserver(self, selector: #selector(lengthUnitToggleTriggered(withNotification:)), name: NSNotification.Name(rawValue: "StarWarsLengthUnitChanged"), object: nil)
        
    }
    
    
    @objc func lengthUnitToggleTriggered(withNotification notification: Notification) {
        
        transporterDetailDataSource.toggleLengthUnit()
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

