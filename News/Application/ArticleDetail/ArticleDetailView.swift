//
//  ArticleDetailView.swift
//  News
//
//  Created by Thomas Valera on 11/10/2018.
//  Copyright © 2018 Valion. All rights reserved.
//

import UIKit

/// Defines the view protocol
protocol ArticleDetailView: class {
    
    //\////////////////////////////////////////
    // MARK: Properties
    //\////////////////////////////////////////
    
    var navigator: ArticleDetailNavigator { get }
    
    //\////////////////////////////////////////
    // MARK: Methods
    //\////////////////////////////////////////
    
    /// Loads the image of the corresponding article
    ///
    /// - Parameters:
    ///   - image: The image to load
    ///   - article: The article to load the image for
    func loadImage(_ image: UIImage, forArticle article: Article)
    
}
