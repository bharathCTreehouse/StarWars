//
//  ErrorUtilities.swift
//  StarWars
//
//  Created by Bharath on 29/05/19.
//  Copyright © 2019 Bharath Chandrashekar. All rights reserved.
//

import Foundation


extension Error {
    
    var isUrlDataTaskCancelled: Bool {
        return (self as NSError).code == NSURLErrorCancelled
    }
}
