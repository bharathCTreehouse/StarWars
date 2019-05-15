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
    
    var characterDetailDataSource: StarWarsCharacterViewData
    
    override init(withDetailDataSource dataSource: StarWarsDetailDataSource) {
        
        characterDetailDataSource = dataSource as! StarWarsCharacterViewData
        super.init(withDetailDataSource: dataSource)
    }
    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
