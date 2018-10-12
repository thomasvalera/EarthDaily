//
//  ArticleDetailNavigator.swift
//  News
//
//  Created by Thomas Valera on 11/10/2018.
//  Copyright © 2018 Valion. All rights reserved.
//

import UIKit
import SafariServices

/// A navigator for ArticleDetailController
class ArticleDetailNavigator {
    
    //\////////////////////////////////////////
    // MARK: Public Properties
    //\////////////////////////////////////////
    
    /* Add public properties here */
    
    //\////////////////////////////////////////
    // MARK: Private Properties
    //\////////////////////////////////////////
    
    weak private var viewController: ArticleDetailController?
    
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
            print("Deinit ArticleDetailNavigator")
        #endif
    }
    
    func attachViewController(controller: ArticleDetailController) {
        self.viewController = controller
    }
    
    func detachViewController() {
        self.viewController = nil
    }
    
    //\////////////////////////////////////////
    // MARK: Methods
    //\////////////////////////////////////////
    
    /// Shows the premium update screen... or an alert
    /// because let's be honest, this is only a demo!
    func showPremiumUpgradeScreen() {
        
        let controller = UIAlertController(title: "ArticleDetailNavigator_alert_premiumUpdateTitle".localized,
                                           message: "ArticleDetailNavigator_alert_premiumUpdateMessage".localized, preferredStyle: .alert)
        
        let cancelAction = UIAlertAction(title: "ArticleDetailNavigator_alert_premiumUpdateButtonClose".localized,
                                         style: .cancel,
                                         handler: nil)
        controller.addAction(cancelAction)
        
        self.viewController?.present(controller, animated: true, completion: nil)
    }
    
    /// Opens the url in an in-app browser
    ///
    /// - Parameter url: The url to open
    func openBrowser(forUrl url: String) {

        guard let url = URL(string: url) else {
            print("Could not open browser, invalid url")
            return
        }
        
        let controller = SFSafariViewController(url: url)
        self.viewController?.present(controller, animated: true, completion: nil)
        
    }
    
}
