//
//  Article.swift
//  News
//
//  Created by Thomas Valera on 10/10/2018.
//  Copyright © 2018 Valion. All rights reserved.
//

import Gloss

/// An article
class Article: JSONDecodable {
    
    //\////////////////////////////////////////
    // MARK: Public Properties
    //\////////////////////////////////////////
    
    let sourceName: String
    let title: String
    let url: String
    let date: Date
    
    let description: String?
    let imageUrl: String?
    let content: String?
    
    //\////////////////////////////////////////
    // MARK: Private Properties
    //\////////////////////////////////////////
    
    /* Add private properties here */
    
    //\////////////////////////////////////////
    // MARK: Constants
    //\////////////////////////////////////////
    
    /* Add constants here */
    
    //\////////////////////////////////////////
    // MARK: Initialization
    //\////////////////////////////////////////
    
    required init?(json: JSON) {
    
        guard let source: JSON = "source" <~~ json,
            let sourceName: String = "name" <~~ source,
            let title: String = "title" <~~ json,
            let url: String = "url" <~~ json,
            let dateRaw: String = "publishedAt" <~~ json else {
                print("Could not parse Article, missing required properties")
                return nil
        }
        
        self.sourceName = sourceName
        self.title = title
        self.url = url
        self.date = Date(withISO8601String: dateRaw)
        
        self.description = "description" <~~ json
        self.imageUrl = "urlToImage" <~~ json
        self.content = "content" <~~ json
        
    }
    
    deinit {
        // Unload stuff from memory such as images and any
        // resources that might trigger a retain cycle.
        
        #if DEBUG_DEINIT
            print("Deinit Article")
        #endif
    }
    
    //\////////////////////////////////////////
    // MARK: Methods
    //\////////////////////////////////////////
    
    /* Add methods here */
    
}

extension Article: Equatable {
    
    /// Chekcs if articles are equal based on the url.
    /// - Note: This supposes the url is unique
    ///
    /// - Parameters:
    ///   - lhs: The first article
    ///   - rhs: The second article
    /// - Returns: True if articles are equal, false otherwise
    static func == (lhs: Article, rhs: Article) -> Bool {
        return lhs.url == rhs.url
    }

}
