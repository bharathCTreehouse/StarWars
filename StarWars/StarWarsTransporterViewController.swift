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
        
        
        let viewModel: StarWarsTransporterViewData? = detailTableView.tableViewDataSource.data as? StarWarsTransporterViewData
        
        
        if let viewModel = viewModel {
            
            if viewModel.currency == .credits {
                
                //Show alert with text field
                
                let textFieldData: AlertControllerTextFieldData = AlertControllerTextFieldData(placeHolderText: nil, borderType: .line, defaultText: "1.0", keypadType: .decimalPad)
                let actionData: AlertControllerActionData =  AlertControllerActionData(actionTitle: "OK", actionStyle: .default)
                let alertData: AlertControllerData = AlertControllerData(title: nil, message: "Enter exchange rate", alertActions: [actionData], textFieldData: [textFieldData])
                
                let alertCont: UIAlertController = AlertViewController.alertController(withAlertControllerData: alertData, completionHandler: { [unowned self] (actionIndex: Int, textFieldStrings: [String]?) -> Void in
                    
                    if let strings = textFieldStrings {
                        
                        if strings.isEmpty == false {
                            
                            let excRate: Double? = Double(strings.first!)
                            guard let unwrappedExcRate = excRate else {
                                self.reloadDetailTableView(atIndexPath: IndexPath(row: 1, section: 0))
                                return
                            }
                            
                            viewModel.toggleCurrency(withExchangeRate: unwrappedExcRate)
                            self.reloadDetailTableView(atIndexPath: IndexPath(row: 1, section: 0))

                            
                        }
                    }
                   
                    
                })
                
                self.present(alertCont, animated: true, completion: nil)
            }
            else if viewModel.currency == .USD {
                viewModel.toggleCurrency()
                reloadDetailTableView(atIndexPath: IndexPath(row: 1, section: 0))
            }
            
        }
        

    }
    
}




extension StarWarsTransporterViewController {
    
    
    override func loadMoreContent() {
        
        super.loadMoreContent()
        
        if let nextUrlString = nextSetUrlString,  let url = URL(string: nextUrlString) {
            
            pickerView.toggleAdditionalViewToInProgressState(true)
            
            let apiClient: StarWarsAPIClient = StarWarsAPIClient()
            let urlReq: URLRequest = URLRequest(url: url)
            
            apiClient.fetchAllTransporters(forRequest: urlReq, withCompletionHandler:  { [unowned self] (movables: [Transporter], nextUrlState: StarWarsNextSetUrlReceiverType, error: Error?) -> Void in
                
                self.pickerView.toggleAdditionalViewToInProgressState(false)
                
                switch nextUrlState {
                case let .update(withUrlString:nextUrlStr):                 self.nextSetUrlString = nextUrlStr
                default: break
                    
                }
                
                
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
                    if error!.isUrlDataTaskCancelled == false {
                        self.showAlert(forError: error!)
                    }
                }
                
            })
        }
        
        
    }
}

