//
//  OverviewViewSpy.swift
//  News
//
//  Created by Thomas Valera on 11/10/2018.
//  Copyright © 2018 Valion. All rights reserved.
//

import XCTest
import UIKit
@testable import News

/// A spy of OverviewView
class OverviewViewSpy: OverviewView {
    
    //\////////////////////////////////////////
    // MARK: Trackers
    //\////////////////////////////////////////
    
    private(set) var loadArticlesPlaceholdersCalled = 0
    private(set) var loadArticlesCalled = 0
    private(set) var loadImageCalled = 0
    private(set) var showErrorCalled = 0
    
    private(set) var loadedArticles: [Article]?
    private(set) var loadedImage: UIImage?
    private(set) var errorMessage: String?
    
    //\////////////////////////////////////////
    // MARK: Expectations
    //\////////////////////////////////////////
    
    var loadArticlesPlaceholdersExpectation: XCTestExpectation?
    var loadArticlesExpectation: XCTestExpectation?
    var loadImageExpectation: XCTestExpectation?
    var showErrorExpectation: XCTestExpectation?
    
    //\////////////////////////////////////////
    // MARK: Methods
    //\////////////////////////////////////////
    
    var navigator: OverviewNavigator = OverviewNavigatorSpy()
    
    func loadArticlesPlaceholders() {
        
        self.loadArticlesPlaceholdersCalled += 1
        self.loadArticlesPlaceholdersExpectation?.fulfill()
        self.loadArticlesPlaceholdersExpectation = nil
    }
    
    func loadArticles(_ articles: [Article]) {
        
        self.loadArticlesCalled += 1
        self.loadedArticles = articles
        self.loadArticlesExpectation?.fulfill()
        self.loadArticlesExpectation = nil
        
    }
    
    func loadImage(_ image: UIImage, forArticle article: Article) {
        
        self.loadImageCalled += 1
        self.loadedImage = image
        self.loadImageExpectation?.fulfill()
        self.loadImageExpectation = nil
    }
    
    func showError(_ message: String) {
        
        self.showErrorCalled += 1
        self.errorMessage = message
        self.showErrorExpectation?.fulfill()
        self.showErrorExpectation = nil
        
    }
    
}
