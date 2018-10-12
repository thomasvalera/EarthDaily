//
//  OverviewController+TableView.swift
//  News
//
//  Created by Thomas Valera on 10/10/2018.
//  Copyright © 2018 Valion. All rights reserved.
//

import UIKit
import ValionKit

/// An extension of OverviewController
extension OverviewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        // Make sure selected article exists
        guard indexPath.row < self.loadedArticles.count else {
            return
        }
        
        // Goto article
        let loadedArticle = self.loadedArticles[indexPath.row]
        self.navigator.goToDetail(forArticle: loadedArticle.article)
        
    }
}

extension OverviewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        // Make sure we are not loading
        guard self.isLoading == false else {
            // Otherwise, show placeholders
            
            let identifier = ArticlePlaceholderTableViewCell.identifier
            
            // Make sure cell is dequeued
            guard let placeholderCell = tableView.dequeueReusableCell(withIdentifier: identifier) else {
                    fatalError("Could not dequeue placeholder cell")
            }
            
            return placeholderCell
        }
        
        let identifier = ArticleTableViewCell.identifier
        
        // Make sure cell is dequeued
        guard let cell = tableView.dequeueReusableCell(withIdentifier: identifier) as? ArticleTableViewCell,
            indexPath.row < self.loadedArticles.count else {
            fatalError("Could not dequeue cell")
        }
        
        // Get article and load cell
        let loadedArticle = self.loadedArticles[indexPath.row]
        loadedArticle.load(inCell: cell)
        
        return cell
    }

    func tableView(_ tableView: UITableView, didEndDisplaying cell: UITableViewCell, forRowAt indexPath: IndexPath) {

        // Make sure row exists and is ArticleTableViewCell
        guard indexPath.row < self.loadedArticles.count, (cell as? ArticleTableViewCell) != nil else {
            return
        }

        // Get article and unload cell
        let loadedArticle = self.loadedArticles[indexPath.row]
        loadedArticle.load(inCell: nil)

    }

    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {

        // Make sure row exists and is ArticleTableViewCell
        guard indexPath.row < self.loadedArticles.count, (cell as? ArticleTableViewCell) != nil else {
            return
        }

        // Get article and download image
        let loadedArticle = self.loadedArticles[indexPath.row]
        self.presenter.downloadImage(forArticle: loadedArticle.article)

    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.isLoading ? self.maxArticlePlaceholders : self.loadedArticles.count
    }
    
}
