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
    
    var imagesDisplayable: [SingleImageDisplayable] = []
    
    init(withImages images: [SingleImageDisplayable], tableViewStyle style: Style) {
        imagesDisplayable = images
        super.init(frame: .zero, style: style)
        translatesAutoresizingMaskIntoConstraints = false
        rowHeight = UITableView.automaticDimension
        estimatedRowHeight = 90.0
        dataSource = self
        register(UINib.init(nibName: "SingleImageTableViewCell", bundle: .main), forCellReuseIdentifier: "imageCell")
        self.tableFooterView = UIView.init()
    }
    
    convenience init(withImages images: [SingleImageDisplayable]) {
        self.init(withImages:images, tableViewStyle: .plain)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

extension SingleImageDisplayableTableView: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return imagesDisplayable.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let image: UIImage = imagesDisplayable[indexPath.row].imageToDisplay
        let imageDesc: NSAttributedString = imagesDisplayable[indexPath.row].attributedTitle
        let backgroundColourToUse: UIColor = imagesDisplayable[indexPath.row].backgroundColour
        
        let cell: SingleImageTableViewCell = tableView.dequeueReusableCell(withIdentifier: "imageCell", for: indexPath) as! SingleImageTableViewCell
        cell.update(withImage: image)
        cell.update(withImageDescriptionTitle: imageDesc)
        cell.update(withBackgroundColour: backgroundColourToUse)
        
        return cell
    }
    
    
}
