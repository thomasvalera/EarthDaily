//
//  OverviewView.swift
//  News
//
//  Created by Thomas Valera on 10/10/2018.
//  Copyright © 2018 Valion. All rights reserved.
//

import UIKit

/// The protocol for an OverviewView
protocol OverviewView: class {
    
    //\////////////////////////////////////////
    // MARK: Properties
    //\////////////////////////////////////////
    
    var navigator: OverviewNavigator { get }
    
    //\////////////////////////////////////////
    // MARK: Methods
    //\////////////////////////////////////////
    
    /// Shows place holder articles for the loading state
    func loadArticlesPlaceholders()
    
    /// Loads the articles
    ///
    /// - Parameter articles: The articles to load
    func loadArticles(_ articles: [Article])
    
    /// Loads the image of the corresponding article
    ///
    /// - Parameters:
    ///   - image: The image to load
    ///   - article: The article to load the image for
    func loadImage(_ image: UIImage, forArticle article: Article)
    
    /// Shows an error message
    ///
    /// - Parameter message: The error message
    func showError(_ message: String)
}
