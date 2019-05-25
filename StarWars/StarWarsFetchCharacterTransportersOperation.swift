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
    func transporterFetched(_ transporter: Transporter, ofType type: TransporterType )
}


class StarWarsFetchCharacterTransportersOperation: StarWarsFetchOperation {
    
    let person: Character
    let type: TransporterType
    weak var delegate: StarWarsFetchCharacterTransporterCompletionProtocol? = nil
    
    
    init?(withTransporterType type: TransporterType, forPerson person: Character, withURL url: URL, withCompletionDelegate delegate: StarWarsFetchCharacterTransporterCompletionProtocol) {
        
        self.person = person
        self.type = type
        self.delegate = delegate
        super.init(withUrl: url)
        
    }
    
    
    override func main() {
        
        super.main()
        
        if jsonData != nil {
            
            DispatchQueue.main.async  {
                
                unowned let weakSelf = self
                
                if self.isCancelled == true {
                    return
                }
                
                do {
                    
                    let jsonDecoder: JSONDecoder = JSONDecoder()
                    jsonDecoder.keyDecodingStrategy = .convertFromSnakeCase
                    let transporter: Transporter = try jsonDecoder.decode(Transporter.self, from: weakSelf.jsonData!)
                    
                    if weakSelf.type == .vehicle {
                        weakSelf.person.listOfVehicles.append(transporter)
                        weakSelf.delegate?.transporterFetched(transporter, ofType: .vehicle)
                    }
                    else {
                        weakSelf.person.listOfStarships.append(transporter)
                        weakSelf.delegate?.transporterFetched(transporter, ofType: .starship)

                    }
                    
                }
                catch let error {
                    print("Err: \(error.localizedDescription)")
                    print("Error: \(error)")
                    return
                }
            }
            
        }
        
    }
    
    
    deinit {
        delegate = nil
    }
    
}
