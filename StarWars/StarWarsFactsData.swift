//
//  StarWarsFactsData.swift
//  StarWars
//
//  Created by Bharath on 25/05/19.
//  Copyright © 2019 Bharath Chandrashekar. All rights reserved.
//

import Foundation

protocol StarWarsSizeAndNameIdentifiable {
    var sizeOfComponent: Double { get }
    var nameOfComponent: String { get }
}


class StarWarsFactsData {
    
    let list: [StarWarsSizeAndNameIdentifiable]
    
    required init(withSizeList dataSource: [StarWarsSizeAndNameIdentifiable]) {
        list = dataSource
    }
}



extension StarWarsFactsData: StarWarsFactsViewDataSource {
    
    var facts: [[String : String]] {
        
        let heights: [Double] = list.compactMap { return $0.sizeOfComponent }
        let lowestHeight: Double? = heights.min()
        let highestHeight: Double? = heights.max()
        
        if let lowestHeight = lowestHeight, let highestHeight = highestHeight {
            
            let lowestHtName: String = self.list[heights.firstIndex(of: lowestHeight)!].nameOfComponent
            let highestHtName: String = self.list[heights.firstIndex(of: highestHeight)!].nameOfComponent
            return [["Smallest": lowestHtName], ["Largest": highestHtName]]
        }
        else {
            return []
        }
    }
    
}
