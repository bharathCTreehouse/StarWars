//
//  SingleImageWithTitleTableViewDataSource.swift
//  StarWars
//
//  Created by Bharath Chandrashekar on 03/05/19.
//  Copyright © 2019 Bharath Chandrashekar. All rights reserved.
//

import Foundation
import UIKit


class SingleImageWithTitleTableViewDataSource: NSObject, UITableViewDataSource {
    
    private var dataSource: [SingleImageDisplayable] = []
    
    init(withDataSource dataSource: [SingleImageDisplayable], forTableView tableView: UITableView) {
        
        self.dataSource = dataSource
        tableView.register(UINib.init(nibName: "SingleImageTableViewCell", bundle: .main), forCellReuseIdentifier: "imageCell")
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataSource.count
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let data: SingleImageDisplayable = dataSource[indexPath.row]
        
        let image: UIImage = data.imageToDisplay
        let imageDesc: NSAttributedString = data.attributedTitle
        let backgroundColourToUse: UIColor = data.backgroundColour
        
        let cell: SingleImageTableViewCell = tableView.dequeueReusableCell(withIdentifier: "imageCell", for: indexPath) as! SingleImageTableViewCell
        cell.update(withImage: image)
        cell.update(withImageDescriptionTitle: imageDesc)
        cell.update(withBackgroundColour: backgroundColourToUse)
        
        return cell
    }
}
