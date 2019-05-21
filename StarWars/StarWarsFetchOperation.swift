//
//  StarWarsFetchOperation.swift
//  StarWars
//
//  Created by Bharath on 21/05/19.
//  Copyright © 2019 Bharath Chandrashekar. All rights reserved.
//

import Foundation


class StarWarsFetchOperation: Operation {
    
    let fetchUrl: URL
    var jsonData: Data? = nil
    
    
    init?(withUrl url: URL?) {
        
        if let url = url {
            fetchUrl = url
        }
        else {
            return nil
        }
    }
    
    
    override func main() {
        
        if self.isCancelled == true {
            return
        }
        
        do {
            let data: Data = try Data.init(contentsOf: fetchUrl)
            
            if self.isCancelled == true {
                return
            }
            if data.isEmpty == false {
                jsonData = data
            }
            else {
                return
            }
        }
        catch {
            return
        }
        
    }
}


