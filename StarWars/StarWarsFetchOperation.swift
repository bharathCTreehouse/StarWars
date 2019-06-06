//
//  StarWarsFetchOperation.swift
//  StarWars
//
//  Created by Bharath on 21/05/19.
//  Copyright © 2019 Bharath Chandrashekar. All rights reserved.
//

import Foundation

protocol StarWarsFetchOperationErrorInformer: class {
    func errorOccurred(_ error: Error)
}


class StarWarsFetchOperation: Operation {
    
    let fetchUrl: URL
    var jsonData: Data? = nil
    weak var errorInformerDelegate: StarWarsFetchOperationErrorInformer? = nil
    
    
    init?(withUrl url: URL?, errorInformerDelegate delegate: StarWarsFetchOperationErrorInformer?) {
        
        if let url = url {
            fetchUrl = url
            errorInformerDelegate = delegate
        }
        else {
            return nil
        }
    }
    
    
    override func main() {
        
        if self.isCancelled == true {
            errorInformerDelegate?.errorOccurred(StarWarsError.operationCancelled)
            errorInformerDelegate = nil
            return
        }
        
        do {
            let data: Data = try Data.init(contentsOf: fetchUrl)
            
            if self.isCancelled == true {
                errorInformerDelegate?.errorOccurred(StarWarsError.operationCancelled)
                errorInformerDelegate = nil

                return

            }
            if data.isEmpty == false {
                jsonData = data
            }
            else {
                
                DispatchQueue.main.async  {
                    
                    weak var weakSelf = self
                    weakSelf?.errorInformerDelegate?.errorOccurred(StarWarsError.invalidData)
                    weakSelf?.errorInformerDelegate = nil
                    
                    return
                }
                
            }
        }
        catch let error {
            
            DispatchQueue.main.async {
                weak var weakSelf = self
                weakSelf?.errorInformerDelegate?.errorOccurred(error)
                weakSelf?.errorInformerDelegate = nil
                return
            }
           
        }
        
    }
    
    
    
    deinit {
        errorInformerDelegate = nil
    }
}


