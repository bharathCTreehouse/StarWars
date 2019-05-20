//
//  StarWarsFetchCharacterHomeOperation.swift
//  StarWars
//
//  Created by Bharath on 21/05/19.
//  Copyright © 2019 Bharath Chandrashekar. All rights reserved.
//

import Foundation

protocol FetchCharacterHomeOperationCompletionProtocol: class {
    func homeFetchedForCharacter(withName name: String)
}

class StarWarsFetchCharacterHomeOperation: StarWarsFetchOperation {
    
    var person: Character
    weak var delegate: FetchCharacterHomeOperationCompletionProtocol? = nil
    
    
    init?(withPerson person: Character, delegate: FetchCharacterHomeOperationCompletionProtocol) {
        
        self.person = person
        self.delegate = delegate
        super.init(withUrl: person.homeURL)
    }
    

    override func main() {
        
        super.main()
        
        if jsonData != nil {
            
            DispatchQueue.main.async  {
                
                unowned let weakSelf = self
                
                do {
                    let jsonDictionary: [String: Any]? = try JSONSerialization.jsonObject(with: weakSelf.jsonData!, options: .allowFragments) as? [String: Any]
                    
                    if let jsonDictionary = jsonDictionary {
                        weakSelf.person.home = jsonDictionary["name"] as? String
                        weakSelf.delegate?.homeFetchedForCharacter(withName: weakSelf.person.name)
                    }
                }
                catch {
                    return
                }
            }
            
            
        }
        
    }
    
}
