//
//  StarWarsDetailViewController.swift
//  StarWars
//
//  Created by Bharath on 14/05/19.
//  Copyright © 2019 Bharath Chandrashekar. All rights reserved.
//

import Foundation
import UIKit

protocol AttributeNameProtocol {
    var allNames: [String] { get }
}


class StarWarsDetailViewController: UIViewController, SelectionPickerViewProtocol, AttributeNameProtocol, StarWarsFactsViewDataSource {
    
    
    
    var detailDataSource: StarWarsDetailDataSource
    private var detailTableView: StarWarsDetailTableView
    lazy var pickerView: SelectionPickerView = {
        return SelectionPickerView(withList: [], delegate: self)
    }()
    
    
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
        
        let factsView: StarWarsFactsView = StarWarsFactsView(withDataSource: self)
        view.addSubview(factsView)
        factsView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor).isActive = true
        factsView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor).isActive = true
        factsView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor).isActive = true
        
        view.addSubview(pickerView)
        pickerView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor).isActive = true
        pickerView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor).isActive = true
        pickerView.bottomAnchor.constraint(equalTo: factsView.safeAreaLayoutGuide.topAnchor).isActive = true
        pickerView.updateTitleList(withList: allNames)

        view.addSubview(detailTableView)
        detailTableView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor).isActive = true
        detailTableView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor).isActive = true
        detailTableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
        detailTableView.bottomAnchor.constraint(equalTo: pickerView.topAnchor).isActive = true
        
        detailTableView.backgroundColor = UIColor.init(red: 26.0/155.0, green: 32.0/155.0, blue: 36.0/155.0, alpha: 1.0)
        
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        detailTableView.flashScrollIndicators()
    }
    
    
    func reloadDetailTableView() {
        detailTableView.reloadData()
    }
    
    
    func reloadDetailTableView(atIndexPath indexPath: IndexPath) {
        detailTableView.reloadRows(at: [indexPath], with: .automatic)
    }
    
    
    
    func selectedPickerIndex(index: Int) {
        detailTableView.updateDataSource(detailDataSource)
        reloadDetailTableView()
    }
    
    
    
    var allNames: [String] {
        return []
    }
    
    
    
    var facts: [[String : String]] {
        return []
    }


    
}


