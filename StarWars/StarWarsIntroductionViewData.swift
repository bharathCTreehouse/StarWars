//
//  StarWarsIntroductionViewData.swift
//  StarWars
//
//  Created by Bharath Chandrashekar on 29/04/19.
//  Copyright © 2019 Bharath Chandrashekar. All rights reserved.
//

import Foundation
import UIKit


class StarWarsIntroductionViewData {
    
    let starWarsIntroData: StarWarsIntroductionData
    
    init(withStarWarsIntroData data: StarWarsIntroductionData) {
        starWarsIntroData = data
    }
    
    var image: UIImage? {
        return UIImage(named: starWarsIntroData.imageName)
    }
    
    var attributedString: NSAttributedString {
        
        let attrColor: UIColor = UIColor.init(red: 96.0/155.0, green: 209.0/155.0, blue: 255.0/155.0, alpha: 1.0)

        let attrString: NSAttributedString = NSAttributedString.init(string: starWarsIntroData.componentName, attributes: [NSAttributedString.Key.font : UIFont.boldSystemFont(ofSize: 20.0), NSAttributedString.Key.foregroundColor : attrColor])
        return attrString
    }
}


extension StarWarsIntroductionViewData: SingleImageDisplayable {
    
    var attributedTitle: NSAttributedString {
        return self.attributedString
    }
    
    
    var imageToDisplay: UIImage {
        return self.image!
    }
    
    
    var backgroundColour: UIColor {
        return UIColor.init(red: 26.0/155.0, green: 32.0/155.0, blue: 36.0/155.0, alpha: 1.0)
    }
}
