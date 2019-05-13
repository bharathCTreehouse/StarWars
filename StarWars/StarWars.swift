//
//  StarWars.swift
//  StarWars
//
//  Created by Bharath on 13/05/19.
//  Copyright © 2019 Bharath Chandrashekar. All rights reserved.
//

import Foundation

protocol EndPoint {
    var base: String { get }
    var path: String { get }
    var queryItems: [URLQueryItem]? { get }
}

extension EndPoint {
    
    var base: String {
        return "https://swapi.co/api/"
    }
    
    var urlComponents: URLComponents? {
        var components: URLComponents? = URLComponents(string: base)
        components?.path = path
        components?.queryItems = queryItems
        return components
    }
    
    
    var urlRequest: URLRequest? {
        if let url = urlComponents?.url {
            return URLRequest(url: url)
        }
        else {
            return nil
        }
    }
}


enum StarWars {
    case character (FetchCriteria)
    case vehicle (FetchCriteria)
    case starship (FetchCriteria)
}

extension StarWars: EndPoint {
    
    var path: String {
        
        switch self {
            
            case .character(let criteria):
                if let identifier = criteria.IdUsedTofetch() {
                    //Fetching based on an ID.
                    return "/api/people/\(identifier)/"
                }
                else {
                    //Fetching everything.
                    return "/api/people/"
                }
            
            
            case .starship(let criteria):
                if let identifier = criteria.IdUsedTofetch() {
                    //Fetching based on an ID.
                    return "/api/starships/\(identifier)/"
                }
                else {
                    //Fetching everything.
                    return "/api/starships/"
                }
            
            case .vehicle(let criteria):
                if let identifier = criteria.IdUsedTofetch() {
                    //Fetching based on an ID.
                    return "/api/vehicles/\(identifier)/"
                }
                else {
                    //Fetching everything.
                    return "/api/vehicles/"
            }
        }
    }
    
    var queryItems: [URLQueryItem]? {
        return nil
    }
}


enum FetchCriteria {
    case all
    case basedOnID(Int)
    
    func IdUsedTofetch() -> Int? {
        
        switch self {
            case .all: return nil
            case .basedOnID(let identifier): return identifier
        }
    }
}

