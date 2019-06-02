//
//  StarWarsAPIClient.swift
//  StarWars
//
//  Created by Bharath on 13/05/19.
//  Copyright © 2019 Bharath Chandrashekar. All rights reserved.
//

import Foundation

enum StarWarsError: Error {
    case invalidData
    case jsonParsingFailure(message: String)
    case invalidResponse
    case failedResponse
    case operationCancelled
    
    
    func starWarsErrorDescription() -> String {
        
        switch self {
        case .invalidData: return "Invalid data returned."
        case let .jsonParsingFailure(message: parsingErrString):return parsingErrString
        case .invalidResponse: return "Invalid response recieved."
        case .failedResponse: return "Response failed."
        case .operationCancelled: return "Operation cancelled."
            
        }
    }
}


enum StarWarsNextSetUrlReceiverType {
    case noUpdate
    case update(withUrlString: String?)
    
    var urlString: String? {
        switch self {
            case .noUpdate: return nil
            case let .update(withUrlString: urlString): return urlString
        }
    }
}


class StarWarsAPIClient {
    
    private var fetchCharactersDataTask: URLSessionDataTask? = nil
    private var fetchTransportersDataTask: URLSessionDataTask? = nil

    
    func fetchAllCharacters(forRequest request: URLRequest, withCompletionHandler handler: @escaping  (([Character], StarWarsNextSetUrlReceiverType, Error?) -> Void)) {
        
        
        let session: URLSession = URLSession(configuration: .default)
        
        fetchCharactersDataTask = session.dataTask(with: request, completionHandler: { (json: Data?, response: URLResponse?, error: Error?) -> Void in
            
            
            DispatchQueue.main.async {
                
                if error != nil {
                    handler([], .noUpdate, error)
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
                                handler(fetchResult.people,.update(withUrlString: fetchResult.next), nil)
                            }
                            catch let error {
                                handler([], .noUpdate,  StarWarsError.jsonParsingFailure(message: error.localizedDescription))
                            }
                            
                        }
                        else {
                            handler([], .noUpdate,  StarWarsError.invalidData)
                        }
                        
                    }
                    else {
                        handler([], .noUpdate,  StarWarsError.failedResponse)
                    }
                    
                }
                else {
                    handler([], .noUpdate, StarWarsError.invalidResponse)
                }
                
                
            }
            
        })
        
        fetchCharactersDataTask?.resume()
    }
    
    
    
    func fetchAllTransporters(forRequest request: URLRequest, withCompletionHandler handler: @escaping (([Transporter], StarWarsNextSetUrlReceiverType, Error?) -> Void)) {
        
        
        let session: URLSession = URLSession(configuration: .default)
        
        fetchTransportersDataTask = session.dataTask(with: request, completionHandler: { (json: Data?, response: URLResponse?, error: Error?) -> Void in
            
            
            DispatchQueue.main.async {
                
                if error != nil {
                    handler([], .noUpdate, error)
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
                                handler(fetchResult.movables, .update(withUrlString: fetchResult.next), nil)
                            }
                            catch let error {
                                handler([], .noUpdate, StarWarsError.jsonParsingFailure(message: error.localizedDescription))
                            }
                            
                        }
                        else {
                            handler([], .noUpdate, StarWarsError.invalidData)
                        }
                        
                    }
                    else {
                        handler([], .noUpdate, StarWarsError.failedResponse)
                    }
                    
                }
                else {
                    handler([], .noUpdate, StarWarsError.invalidResponse)
                }
                
                
            }
            
        })
        
        fetchTransportersDataTask?.resume()
        
    }
    
    
    
    deinit {
        fetchCharactersDataTask = nil
        fetchTransportersDataTask = nil
    }
    
}



extension StarWarsAPIClient {
    
    
    func cancelAllPendingDataTasks() {
        
        fetchCharactersDataTask?.cancel()
        fetchCharactersDataTask = nil
        
        fetchTransportersDataTask?.cancel()
        fetchTransportersDataTask = nil
    }
    
}
