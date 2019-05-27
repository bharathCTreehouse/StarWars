//
//  StarWarsAPIClient.swift
//  StarWars
//
//  Created by Bharath on 13/05/19.
//  Copyright © 2019 Bharath Chandrashekar. All rights reserved.
//

import Foundation

enum StarWarsError: Error {
    case noInternetConnection
    case invalidData
    case jsonParsingFailure(message: String)
    case invalidResponse
    case failedResponse
}


class StarWarsAPIClient {
    
    func fetchAllCharacters(forRequest request: URLRequest, withCompletionHandler handler: @escaping  (([Character], String?, Error?) -> Void)) {
        
        let session: URLSession = URLSession(configuration: .default)
        
        let task = session.dataTask(with: request, completionHandler: { (json: Data?, response: URLResponse?, error: Error?) -> Void in
            
            
            DispatchQueue.main.async {
                
                if error != nil {
                    handler([],nil, error)
                    return
                }
                
                if let httpResponse = response as? HTTPURLResponse {
                    
                    if httpResponse.statusCode == 200 {
                        
                        //Success case.
                        
                        if let json = json {
                            
                            let jsonDecoder: JSONDecoder = JSONDecoder()
                            jsonDecoder.keyDecodingStrategy = .convertFromSnakeCase
                            
                            do {
                                let fetchResult: StarWarsPeopleFetchResult = try  jsonDecoder.decode(StarWarsPeopleFetchResult.self, from: json)
                                handler(fetchResult.people,fetchResult.next, nil)
                            }
                            catch let error {
                                handler([],nil, StarWarsError.jsonParsingFailure(message: error.localizedDescription))
                            }
                            
                        }
                        else {
                            handler([],nil, StarWarsError.invalidData)
                        }
                        
                    }
                    else {
                        handler([],nil, StarWarsError.failedResponse)
                    }
                    
                }
                else {
                    handler([],nil, StarWarsError.invalidResponse)
                }
                
                
            }
            
        })
        
        task.resume()
    }
    
    
    func fetchAllTransporters(forRequest request: URLRequest, withCompletionHandler handler: @escaping (([Transporter], String?, Error?) -> Void)) {
        
        
        let session: URLSession = URLSession(configuration: .default)
        
        let task = session.dataTask(with: request, completionHandler: { (json: Data?, response: URLResponse?, error: Error?) -> Void in
            
            
            DispatchQueue.main.async {
                
                if error != nil {
                    handler([],nil, error)
                    return
                }
                
                if let httpResponse = response as? HTTPURLResponse {
                    
                    if httpResponse.statusCode == 200 {
                        
                        //Success case.
                        
                        if let json = json {
                            
                            let jsonDecoder: JSONDecoder = JSONDecoder()
                            jsonDecoder.keyDecodingStrategy = .convertFromSnakeCase
                            
                            do {
                                let fetchResult: StarWarsMovableFetchResult = try  jsonDecoder.decode(StarWarsMovableFetchResult.self, from: json)
                                handler(fetchResult.movables, fetchResult.next, nil)
                            }
                            catch let error {
                                handler([], nil, StarWarsError.jsonParsingFailure(message: error.localizedDescription))
                            }
                            
                        }
                        else {
                            handler([],nil, StarWarsError.invalidData)
                        }
                        
                    }
                    else {
                        handler([],nil, StarWarsError.failedResponse)
                    }
                    
                }
                else {
                    handler([], nil, StarWarsError.invalidResponse)
                }
                
                
            }
            
        })
        
        task.resume()
        
    }
    
}
