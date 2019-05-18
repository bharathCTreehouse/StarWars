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
    private var detailTableView: StarWarsDetailTableView
    
    init(withDetailDataSource dataSource: StarWarsDetailDataSource) {
        detailDataSource = dataSource
        detailTableView = StarWarsDetailTableView(withDetailData: detailDataSource)
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    override func loadView() {
        
        self.view = UIView()
        view.addSubview(detailTableView)
        
        detailTableView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor).isActive = true
        detailTableView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor).isActive = true
        detailTableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
        detailTableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor).isActive = true
        
    }
    
    
    func reloadDetailTableView() {
        detailTableView.reloadData()
    }
    
    
    func reloadDetailTableView(atIndexPath indexPath: IndexPath) {
        detailTableView.reloadRows(at: [indexPath], with: .automatic)
    }
    
}
