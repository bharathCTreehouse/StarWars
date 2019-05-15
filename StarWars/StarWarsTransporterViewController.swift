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
    
    override init(withDetailDataSource dataSource: StarWarsDetailDataSource) {
        
        transporterDetailDataSource = dataSource as! StarWarsTransporterViewData
        super.init(withDetailDataSource: dataSource)
    }
    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
