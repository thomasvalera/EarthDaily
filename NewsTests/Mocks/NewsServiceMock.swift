//
//  NewsServiceMock.swift
//  News
//
//  Created by Thomas Valera on 11/10/2018.
//  Copyright © 2018 Valion. All rights reserved.
//

import Gloss
@testable import News

/// A mock of NewsService
class NewsServiceMock: NewsService {
    
    //\////////////////////////////////////////
    // MARK: Public Properties
    //\////////////////////////////////////////
    
    /// True if the call should all fail, false otherwise
    var shouldFail: Bool = false
    
    //\////////////////////////////////////////
    // MARK: Private Properties
    //\////////////////////////////////////////
    
    private let validArticleJSON: JSON = [
        "source": [
            "name": "sourceName"
        ],
        "title": "title",
        "description": "description",
        "url": "url",
        "urlToImage": "imageUrl",
        "publishedAt": "2018-10-11T01:02:03Z",
        "content": "content"
    ]
    
    //\////////////////////////////////////////
    // MARK: Methods
    //\////////////////////////////////////////
    
    override func getHeadlines(onComplete completionClosure: @escaping ([Article]) -> Void,
                               onFailure failureClosure: @escaping (Error) -> Void) {
        
        // Make sure it should not fail
        guard self.shouldFail == false else {
            failureClosure(EDError.invalidResponseType)
            return
        }
        
        // Parse 2 articles
        guard let article1 = Article(json: self.validArticleJSON),
            let article2 = Article(json: self.validArticleJSON) else {
                failureClosure(EDError.invalidResponseType)
                return
        }
        
        // Call completion
        completionClosure([article1, article2])
        
    }
    
    override func getImage(forUrl url: URL, onComplete completionClosure: @escaping (UIImage) -> Void,
                           onFailure failureClosure: @escaping (Error) -> Void) {
        
        // Make sure it should not fail
        guard self.shouldFail == false else {
            failureClosure(EDError.invalidResponseType)
            return
        }
        
        // Initialize new image
        let image = UIImage()
        completionClosure(image)
        
    }
    
}
