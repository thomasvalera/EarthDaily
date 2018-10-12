//
//  Array+Gloss.swift
//  News
//
//  Created by Thomas Valera on 10/10/2018.
//  Copyright © 2018 Valion. All rights reserved.
//

import Gloss

/// An extension of Array adding gloss-like functionality
extension Array where Element: JSONDecodable {
    
    //\////////////////////////////////////////
    // MARK: - Methods
    //\////////////////////////////////////////
    
    /// Returns array of new objects created from provided JSON array.
    /// Failed decodings are ignored and not returned in the final array.
    ///
    /// - Note: In contrary with from(jsonArray:), this method ignores failed decodings and always returns an array.
    /// - Parameter failableJSONArray: An array containing JSON objects that might fail decoding
    /// - Returns: An array of objects created from valid JSON
    static func from(failableJSONArray: [JSON]) -> [Element] {
        
        var models: [Element] = []
        
        for json in failableJSONArray {
            let model = Element(json: json)
            
            if let model = model {
                models.append(model)
            }
        }
        
        return models
        
    }
    
}
