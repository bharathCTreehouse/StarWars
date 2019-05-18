//
//  StarWarsDetailTableView.swift
//  StarWars
//
//  Created by Bharath on 14/05/19.
//  Copyright © 2019 Bharath Chandrashekar. All rights reserved.
//

import Foundation
import UIKit



class StarWarsDetailTableView: UITableView {
    
    var tableViewDataSource: StarWarsDetailTableViewDataSource
    
    required init(withDetailData data: StarWarsDetailDataSource) {
        
        tableViewDataSource = StarWarsDetailTableViewDataSource(withDetailDataSource: data)
        super.init(frame: .zero, style: .plain)
        
        translatesAutoresizingMaskIntoConstraints = false
        self.register(UINib.init(nibName: "StarWarsDetailTableViewCell", bundle: .main), forCellReuseIdentifier: "detailCell")
        self.register(StarWarsLengthUnitToggleTableViewCell.classForCoder(), forCellReuseIdentifier: "lengthToggleCell")
        self.register(StarWarsCostUnitToggleTableViewCell.classForCoder(), forCellReuseIdentifier: "costToggleCell")

        dataSource = tableViewDataSource
        estimatedRowHeight = 90
        rowHeight = UITableView.automaticDimension
    }
    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
