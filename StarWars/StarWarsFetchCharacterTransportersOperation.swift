//
//  StarWarsFetchCharacterTransportersOperation.swift
//  StarWars
//
//  Created by Bharath on 25/05/19.
//  Copyright © 2019 Bharath Chandrashekar. All rights reserved.
//

import Foundation

enum TransporterType {
    case vehicle
    case starship
}

protocol StarWarsFetchCharacterTransporterCompletionProtocol: class {
    func transporterFetched(_ transporter: Transporter?, ofType type: TransporterType, withError error: Error?)
}


class StarWarsFetchCharacterTransportersOperation: StarWarsFetchOperation {
    
    let person: Character
    let type: TransporterType
    weak var delegate: StarWarsFetchCharacterTransporterCompletionProtocol? = nil
    
    
    init?(withTransporterType type: TransporterType, forPerson person: Character, withURL url: URL, withCompletionDelegate delegate: StarWarsFetchCharacterTransporterCompletionProtocol) {
        
        self.person = person
        self.type = type
        self.delegate = delegate
        super.init(withUrl: url, errorInformerDelegate: nil)
        
    }
    
    
    override func main() {
        
        errorInformerDelegate = self
        
        super.main()
        
        if jsonData != nil {
            
            DispatchQueue.main.async  {
                
                unowned let weakSelf = self
                
                if self.isCancelled == true {
                    weakSelf.delegate?.transporterFetched(nil, ofType: weakSelf.type, withError: StarWarsError.operationCancelled)
                    return
                }
                
                do {
                    
                    let jsonDecoder: JSONDecoder = JSONDecoder()
                    jsonDecoder.keyDecodingStrategy = .convertFromSnakeCase
                    let transporter: Transporter = try jsonDecoder.decode(Transporter.self, from: weakSelf.jsonData!)
                    
                    if weakSelf.type == .vehicle {
                        weakSelf.person.listOfVehicles.append(transporter)
                        weakSelf.delegate?.transporterFetched(transporter, ofType: .vehicle, withError: nil)
                    }
                    else {
                        weakSelf.person.listOfStarships.append(transporter)
                        weakSelf.delegate?.transporterFetched(transporter, ofType: .starship, withError: nil)

                    }
                    
                }
                catch {
                     weakSelf.delegate?.transporterFetched(nil, ofType: weakSelf.type, withError: StarWarsError.jsonParsingFailure(message: "Failed to parse json."))
                    return
                }
            }
            
        }
        else {
            errorInformerDelegate = nil
        }
        
    }
    
    
    deinit {
        delegate = nil
    }
    
}


extension StarWarsFetchCharacterTransportersOperation: StarWarsFetchOperationErrorInformer {
    
    
    func errorOccurred(_ error: Error) {
        delegate?.transporterFetched(nil, ofType: self.type, withError: error)
    }
}
