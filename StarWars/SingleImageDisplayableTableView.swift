//
//  SingleImageDisplayableTableView.swift
//  StarWars
//
//  Created by Bharath Chandrashekar on 29/04/19.
//  Copyright © 2019 Bharath Chandrashekar. All rights reserved.
//

import Foundation
import UIKit

protocol SingleImageDisplayable {
    var imageToDisplay: UIImage { get }
    var attributedTitle: NSAttributedString { get }
    var backgroundColour: UIColor { get }
}

extension SingleImageDisplayable {
    
    var backgroundColour: UIColor {
        return UIColor.white
    }
}


class SingleImageDisplayableTableView: UITableView {
    
    var dataSourceForTableView: SingleImageWithTitleTableViewDataSource? = nil
    
    init(withImages images: [SingleImageDisplayable], tableViewStyle style: Style) {
        
        super.init(frame: .zero, style: style)
        translatesAutoresizingMaskIntoConstraints = false
        rowHeight = UITableView.automaticDimension
        estimatedRowHeight = 90.0
        dataSourceForTableView = SingleImageWithTitleTableViewDataSource(withDataSource: images, forTableView: self)
        dataSource = dataSourceForTableView
        self.tableFooterView = UIView.init()
    }
    
    convenience init(withImages images: [SingleImageDisplayable]) {
        self.init(withImages:images, tableViewStyle: .plain)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    deinit {
        dataSourceForTableView = nil
    }
    
}
