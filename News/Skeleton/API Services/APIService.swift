//
//  APIService.swift
//  News
//
//  Created by Thomas Valera on 10/10/2018.
//  Copyright © 2018 Valion. All rights reserved.
//

import Alamofire
import Gloss

/// The root class of all services
class APIService {
    
    //\////////////////////////////////////////
    // MARK: Initialization
    //\////////////////////////////////////////
    
    deinit {
        // Unload stuff from memory such as images and any
        // resources that might trigger a retain cycle.
        
        #if DEBUG_DEINIT
            print("Deinit APIService")
        #endif
    }
    
    //\////////////////////////////////////////
    // MARK: Methods
    //\////////////////////////////////////////
    
    /// Makes a GET request to the given url
    ///
    /// - Parameters:
    ///   - url: The URL to request
    ///   - completionClosure: The closure to call upon completion
    ///   - failureClosure: The closure to call upon failure
    func request(url: String, onComplete completionClosure: @escaping (JSON) -> Void, onFailure failureClosure: @escaping (Error) -> Void) {
        
        // Request
        Alamofire.request(url).validate().responseJSON { (response) in
            
            switch response.result {
            case .success(let value):
                    
                // Make sure response is a string
                guard let json = value as? JSON else {
                    failureClosure(EDError.invalidResponseType)
                    return
                }
                
                completionClosure(json)
                
            case .failure(let error):
                failureClosure(error)
            }
            
        }
        
    }
    
}
