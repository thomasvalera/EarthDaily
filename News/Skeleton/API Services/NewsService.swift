//
//  NewsService.swift
//  News
//
//  Created by Thomas Valera on 10/10/2018.
// Copyright © 2018 Valion. All rights reserved.
//

import Gloss
import AlamofireImage

/// A service for the newsapi.org endpoints
class NewsService: APIService {
    
    //\////////////////////////////////////////
    // MARK: Public Properties
    //\////////////////////////////////////////
    
    //\////////////////////////////////////////
    // MARK: Private Properties
    //\////////////////////////////////////////
    
    private let headlinesPath = "https://newsapi.org/v2/top-headlines?country=us&apiKey=6b1c1a46ca5e47ec811c4187df005cb5"
    private let imageDownloader = ImageDownloader()
    
    //\////////////////////////////////////////
    // MARK: Initialization
    //\////////////////////////////////////////
    
    deinit {
        // Unload resources from memory that might trigger a retain cycle.
        
        #if DEBUG_DEINIT
            print("Deinit NewsService")
        #endif
    }
    
    //\////////////////////////////////////////
    // MARK: Methods
    //\////////////////////////////////////////
    
    /// Gets the headerlines from the API
    ///
    /// - Parameters:
    ///   - completionClosure: The closure to call upon completion
    ///   - failureClosure: The closure to call upon failure
    func getHeadlines(onComplete completionClosure: @escaping ([Article]) -> Void, onFailure failureClosure: @escaping (Error) -> Void) {
        
        super.request(url: self.headlinesPath, onComplete: { (json) in
            // If success
            
            // Make sure articles are there
            guard let articlesData: [JSON] = "articles" <~~ json else {
                print("Could not find articles when parsing response")
                failureClosure(EDError.invalidResponseType)
                return
            }
            
            // Parse and return articles
            let articles = [Article].from(failableJSONArray: articlesData)
            completionClosure(articles)
            
        }) { (error) in
            // If failure
            failureClosure(error)
        }
        
    }
    
    /// Gets the image from the url
    ///
    /// - Parameters:
    ///   - url: The url to the image
    ///   - completionClosure: The closure to call upon completion
    ///   - failureClosure: The closure to call upon failure
    func getImage(forUrl url: URL, onComplete completionClosure: @escaping (UIImage) -> Void, onFailure failureClosure: @escaping (Error) -> Void) {
        
        self.imageDownloader.download(URLRequest(url: url)) { (response) in
            
            // Make sure image exists
            guard let image = response.result.value else {
                failureClosure(EDError.invalidResponseType)
                return
            }
            
            completionClosure(image)
            
        }
        
    }
    
}
