//
//  OverviewNavigator.swift
//  News
//
//  Created by Thomas Valera on 10/10/2018.
//  Copyright © 2018 Valion. All rights reserved.
//

/// A navigator for OverviewController
class OverviewNavigator {
    
    //\////////////////////////////////////////
    // MARK: Public Properties
    //\////////////////////////////////////////
    
    /* Add public properties here */
    
    //\////////////////////////////////////////
    // MARK: Private Properties
    //\////////////////////////////////////////
    
    weak private var viewController: OverviewController?
    
    //\////////////////////////////////////////
    // MARK: Constants
    //\////////////////////////////////////////
    
    /* Add constants here */
    
    //\////////////////////////////////////////
    // MARK: Initialization
    //\////////////////////////////////////////
    
    deinit {
        // Unload stuff from memory such as images and any
        // resources that might trigger a retain cycle.
        
        #if DEBUG_DEINIT
            print("Deinit OverviewNavigator")
        #endif
    }
    
    func attachViewController(controller: OverviewController) {
        self.viewController = controller
    }
    
    func detachViewController() {
        self.viewController = nil
    }
    
    //\////////////////////////////////////////
    // MARK: Methods
    //\////////////////////////////////////////
    
    /// Goes to the detail screen of an article
    ///
    /// - Parameter article: The article to go to
    func goToDetail(forArticle article: Article) {
        
        let controller = ArticleDetailController.instantiate(withArticle: article)
        self.viewController?.navigationController?.pushViewController(controller, animated: true)
        
    }
    
}
