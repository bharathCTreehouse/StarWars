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


class StarWarsDetailViewController: UIViewController, SelectionPickerViewProtocol, AttributeNameProtocol {
    
    
    private(set) var detailTableView: StarWarsDetailTableView!
    
    lazy var pickerView: SelectionPickerView = {
        
        let activityViewData: StarWarsActivityIndicatorData = StarWarsActivityIndicatorData(withButtonAttrs: [.title("Show more"), .titleFont(UIFont.boldSystemFont(ofSize: 19.0))], activityIndicatorAttr: .style(.gray), color: UIColor.white)
        
        return SelectionPickerView(withList: [], delegate: self, additionalViewDataSource: activityViewData, additionalViewDelegate: self)
    }()
    
    var nextSetUrlString: String? = nil
    
    lazy var factsView: StarWarsFactsView = {
        return StarWarsFactsView(withDataSource: nil)
    }()
    
    var tableViewBottomConst: NSLayoutConstraint? = nil
    
    
    
    init(withDetailDataSource dataSource: StarWarsDetailDataSource, nextSetUrlString urlString: String? ) {
        
        nextSetUrlString = urlString
        super.init(nibName: nil, bundle: nil)
        detailTableView = StarWarsDetailTableView(withDetailData: dataSource)
    }
    
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    
    override func loadView() {
        
        self.view = UIView()
        
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
        tableViewBottomConst = detailTableView.bottomAnchor.constraint(equalTo: pickerView.topAnchor)
        tableViewBottomConst!.isActive = true
        
       
        detailTableView.backgroundColor = UIColor.init(red: 26.0/155.0, green: 32.0/155.0, blue: 36.0/155.0, alpha: 1.0)
        
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
        reloadDetailTableView()
    }
    
    
    
    var allNames: [String] {
        return []
    }
    
    
    deinit {
        nextSetUrlString = nil
        tableViewBottomConst = nil
    }
}



extension StarWarsDetailViewController: SelectionPickerAdditionalViewProtocol {
    
    
    func additionalViewTapped() {
        loadMoreContent()
    }
    
    
    @objc func loadMoreContent() {
        
        if nextSetUrlString == nil {
            //Show alert and return
            return
        }
        
    }
}



extension StarWarsDetailViewController {
    
    
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        
        super.viewWillTransition(to: size, with: coordinator)
        
        self.tableViewBottomConst!.isActive = false
        
        if UIDevice.current.orientation == .landscapeLeft || UIDevice.current.orientation == .landscapeRight {
            
            self.pickerView.isHidden = true
            
            self.tableViewBottomConst = detailTableView.bottomAnchor.constraint(equalTo: factsView.topAnchor)
        }
        else {
            self.pickerView.isHidden = false
            
            self.tableViewBottomConst = detailTableView.bottomAnchor.constraint(equalTo: pickerView.topAnchor)
        }
        
        self.tableViewBottomConst!.isActive = true
    }

    
}



extension StarWarsDetailViewController {
    
    func updateNavigationTitle(with title: String) {
        self.navigationItem.title = title
    }
    
}


