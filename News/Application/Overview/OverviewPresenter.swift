//
//  OverviewPresenter.swift
//  News
//
//  Created by Thomas Valera on 10/10/2018.
//  Copyright © 2018 Valion. All rights reserved.
//

import Foundation

/// Implements the presenter for OverviewView
class OverviewPresenter {
    
    //\////////////////////////////////////////
    // MARK: Public Properties
    //\////////////////////////////////////////
    
    /* Add public properties */
    
    //\////////////////////////////////////////
    // MARK: Private Properties
    //\////////////////////////////////////////
    
    weak private var view: OverviewView?
    
    private let newsService: NewsService
    
    //\////////////////////////////////////////
    // MARK: Initialization
    //\////////////////////////////////////////
    
    init(newService: NewsService = NewsService()) {
        self.newsService = newService
    }
    
    deinit {
        // Unload stuff from memory such as images and any
        // resources that might trigger a retain cycle.
        
        #if DEBUG_DEINIT
            print("Deinit OverviewPresenter")
        #endif
    }
    
    func attachView(view: OverviewView) {
        self.view = view
    }
    
    func detachView() {
        self.view = nil
    }
    
    //\////////////////////////////////////////
    // MARK: Methods
    //\////////////////////////////////////////
    
    /// Requests the headline articles from the API
    func requestHeadlines() {
        
        // Prepare loading
        self.view?.loadArticlesPlaceholders()
        
        // Get articles
        self.newsService.getHeadlines(onComplete: { [weak self](articles) in
            // If completed, load articles
            self?.view?.loadArticles(articles)
            
        }) { [weak self](_) in
            // If failure, show error
            self?.view?.showError("OverviewController_loadingError".localized)
        }
        
    }
    
    /// Downloads the image for the given article
    ///
    /// - Parameter article: The article to load the image for
    func downloadImage(forArticle article: Article) {
        
        // Make sure url exists
        guard let path = article.imageUrl, let url = URL(string: path) else {
            return
        }
        
        self.newsService.getImage(forUrl: url, onComplete: { (image) in
            self.view?.loadImage(image, forArticle: article)
        }) { (_) in
            // Do nothing and keep it quiet
        }
        
    }
    
}
