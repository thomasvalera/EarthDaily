//
//  ArticleDetailPresenter.swift
//  News
//
//  Created by Thomas Valera on 11/10/2018.
//  Copyright © 2018 Valion. All rights reserved.
//

import AlamofireImage

/// Implements the presenter for ArticleDetailView
class ArticleDetailPresenter {
    
    //\////////////////////////////////////////
    // MARK: Public Properties
    //\////////////////////////////////////////
    
    /* Add public properties */
    
    //\////////////////////////////////////////
    // MARK: Private Properties
    //\////////////////////////////////////////
    
    weak private var view: ArticleDetailView?
    
    private let imageDownloader = ImageDownloader()
    
    //\////////////////////////////////////////
    // MARK: Initialization
    //\////////////////////////////////////////
    
    init() {
    }
    
    deinit {
        // Unload stuff from memory such as images and any
        // resources that might trigger a retain cycle.
        
        #if DEBUG_DEINIT
            print("Deinit ArticleDetailPresenter")
        #endif
    }
    
    func attachView(view: ArticleDetailView) {
        self.view = view
    }
    
    func detachView() {
        self.view = nil
    }
    
    //\////////////////////////////////////////
    // MARK: Methods
    //\////////////////////////////////////////
    
    /// Downloads the image for the given article
    ///
    /// - Parameter article: The article to load the image for
    func downloadImage(forArticle article: Article) {
        
        // Make sure url exists
        guard let path = article.imageUrl, let url = URL(string: path) else {
            return
        }
        
        self.imageDownloader.download(URLRequest(url: url)) { [weak self](response) in
            
            // Make sure image exists
            guard let image = response.result.value else {
                return
            }
            
            // Load
            self?.view?.loadImage(image, forArticle: article)
            
        }
        
    }
    
}
