//
//  OverviewPresenterTests.swift
//  NewsTests
//
//  Created by Thomas Valera on 11/10/2018.
//  Copyright © 2018 Valion. All rights reserved.
//

import XCTest
import Gloss
@testable import News

class OverviewPresenterTests: XCTestCase {

    //\////////////////////////////////////////
    // MARK: Properties
    //\////////////////////////////////////////
    
    var presenterUnderTest: OverviewPresenter!
    var spy: OverviewViewSpy!
    var mockService: NewsServiceMock!
    
    var articleWithImage: Article {
        
        let json: JSON = [
            "source": [
                "name": "sourceName"
            ],
            "title": "title",
            "description": "description",
            "url": "url",
            "urlToImage": "https://www.imaginaryImageUrl.com",
            "publishedAt": "2018-10-11T01:02:03Z",
            "content": "content"
        ]
        
        return Article(json: json)!
    }
    
    var articleWithoutImage: Article {
        
        let json: JSON = [
            "source": [
                "name": "sourceName"
            ],
            "title": "title",
            "description": "description",
            "url": "url",
            "publishedAt": "2018-10-11T01:02:03Z",
            "content": "content"
        ]
        
        return Article(json: json)!
    }
    
    //\////////////////////////////////////////
    // MARK: Tests
    //\////////////////////////////////////////
    
    override func setUp() {
        super.setUp()
        
        // Create mock and spy
        self.mockService = NewsServiceMock()
        self.spy = OverviewViewSpy()
    
        // Create presenter under test
        self.presenterUnderTest = OverviewPresenter(newService: mockService)
        presenterUnderTest.attachView(view: spy)
        
    }

    override func tearDown() {
        
        // Empty all properties
        self.presenterUnderTest = nil
        self.spy = nil
        self.mockService = nil
    }

    /// Test case where requestHeadlines is successful
    func test_requestHeadlines_success() {
        
        // Setup
        self.spy.loadArticlesExpectation = expectation(description: "Articles loaded")
        
        // Given
        XCTAssertNil(self.spy.loadedArticles, "loadedArticles should be nil")
        XCTAssert(self.spy.loadArticlesCalled == 0, "loadedArticlesCalled should be 0")
        XCTAssert(self.spy.loadArticlesPlaceholdersCalled == 0, "loadArticlesPlaceholdersCalled should be 0")
        XCTAssert(self.spy.showErrorCalled == 0, "showErrorCalled should be 0")
        
        // When
        self.presenterUnderTest.requestHeadlines()
        waitForExpectations(timeout: 2)
        
        // Then
        XCTAssertNotNil(self.spy.loadedArticles, "loadedArticles should not be nil")
        XCTAssert(self.spy.loadArticlesCalled == 1, "loadedArticlesCalled should be 1")
        XCTAssert(self.spy.loadArticlesPlaceholdersCalled == 1, "loadArticlesPlaceholdersCalled should be 1")
        XCTAssert(self.spy.showErrorCalled == 0, "showErrorCalled should be 0")
        
    }

    /// Test case where requestHeadlines fails
    func test_requestHeadlines_failure() {
        
        // Setup
        self.spy.showErrorExpectation = expectation(description: "Error shown")
        self.mockService.shouldFail = true
        
        // Given
        XCTAssert(self.spy.loadArticlesCalled == 0, "loadedArticlesCalled should be 0")
        XCTAssert(self.spy.loadArticlesPlaceholdersCalled == 0, "loadArticlesPlaceholdersCalled should be 0")
        XCTAssert(self.spy.showErrorCalled == 0, "showErrorCalled should be 0")
        
        // When
        self.presenterUnderTest.requestHeadlines()
        waitForExpectations(timeout: 2)
        
        // Then
        XCTAssertNil(self.spy.loadedArticles, "loadedArticles should be nil")
        XCTAssert(self.spy.loadArticlesCalled == 0, "loadedArticlesCalled should be 0")
        XCTAssert(self.spy.loadArticlesPlaceholdersCalled == 1, "loadArticlesPlaceholdersCalled should be 1")
        XCTAssert(self.spy.showErrorCalled == 1, "showErrorCalled should be 1")
        XCTAssertNotNil(self.spy.errorMessage, "Error message should not be nil")
        
    }
    
    /// Test case where getImage is successful
    func test_getImage_success() {
        
        // Setup
        self.spy.loadImageExpectation = expectation(description: "Image is loaded")
        
        // Given
        XCTAssert(self.spy.loadImageCalled == 0, "loadImageCalled should be 0")
        XCTAssertNil(self.spy.loadedImage, "loadImageCalled should be nil")
        XCTAssert(self.spy.showErrorCalled == 0, "showErrorCalled should be 0")
        
        // When
        self.presenterUnderTest.downloadImage(forArticle: self.articleWithImage)
        waitForExpectations(timeout: 2)
        
        // Then
        XCTAssert(self.spy.loadImageCalled == 1, "loadImageCalled should be 1")
        XCTAssertNotNil(self.spy.loadedImage, "loadImageCalled should not be nil")
        XCTAssert(self.spy.showErrorCalled == 0, "showErrorCalled should be 0")
        
    }
    
    /// Test case where getImage fails silently
    func test_getImage_failure() {
        
        // Given
        XCTAssert(self.spy.loadImageCalled == 0, "loadImageCalled should be 0")
        XCTAssertNil(self.spy.loadedImage, "loadImageCalled should be nil")
        XCTAssert(self.spy.showErrorCalled == 0, "showErrorCalled should be 0")
        
        // When
        self.presenterUnderTest.downloadImage(forArticle: self.articleWithoutImage)
        _ = XCTWaiter.wait(for: [], timeout: 2)
        
        // Then
        XCTAssert(self.spy.loadImageCalled == 0, "loadImageCalled should be 0")
        XCTAssertNil(self.spy.loadedImage, "loadImageCalled should be nil")
        XCTAssert(self.spy.showErrorCalled == 0, "showErrorCalled should be 0")
        
    }
    
}
