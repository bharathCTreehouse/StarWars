//
//  StarWarsDetailViewController.swift
//  StarWars
//
//  Created by Bharath on 14/05/19.
//  Copyright © 2019 Bharath Chandrashekar. All rights reserved.
//

import Foundation
import UIKit


class StarWarsDetailViewController: UIViewController {
    
    var detailDataSource: StarWarsDetailDataSource
    
    init(withDetailDataSource dataSource: StarWarsDetailDataSource) {
        detailDataSource = dataSource
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    override func loadView() {
        
        self.view = UIView()
        let detailTableView: StarWarsDetailTableView = StarWarsDetailTableView(withDetailData: detailDataSource)
        view.addSubview(detailTableView)
        
        detailTableView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        detailTableView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        detailTableView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        detailTableView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        
    }
    
}
