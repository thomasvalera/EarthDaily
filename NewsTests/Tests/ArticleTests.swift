//
//  ArticleTests.swift
//  NewsTests
//
//  Created by Thomas Valera on 11/10/2018.
//  Copyright © 2018 Valion. All rights reserved.
//

import XCTest
import Gloss
@testable import News

class ArticleTests: XCTestCase {
    
    //\////////////////////////////////////////
    // MARK: Properties
    //\////////////////////////////////////////
    
    let validArticleJSON: JSON = [
        "source": [
            "name": "sourceName"
        ],
        "title": "title",
        "description": "description",
        "url": "url",
        "urlToImage": "imageUrl",
        "publishedAt": "2018-10-11T01:02:03Z",
        "content": "content"
    ]
    
    //\////////////////////////////////////////
    // MARK: Tests
    //\////////////////////////////////////////
    
    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    /// Test case where jsonInit is successful
    func testJSONInit() {
        
        // Get json
        let json = self.validArticleJSON
        
        // Parse
        let article = Article(json: json)
        
        // Assert
        XCTAssertNotNil(article, "Article should not have been nil")
        XCTAssertEqual(article!.sourceName, "sourceName", "sourceName should be equal to sourceName")
        XCTAssertEqual(article!.title, "title", "title should be equal to title")
        XCTAssertEqual(article!.url, "url", "url should be equal to url")
        XCTAssertEqual(article!.date, Date(withISO8601String: "2018-10-11T01:02:03Z"),
                       "date should be equal to 2018-10-11T01:02:03Z")
        XCTAssertEqual(article!.description, "description", "description should be equal to description")
        XCTAssertEqual(article!.imageUrl, "imageUrl", "imageUrl should be equal to imageUrl")
        XCTAssertEqual(article!.content, "content", "content should be equal to content")
        
    }
    
    /// Test case where jsonInit is missing a required property
    func testJSONInit_missingRequired_source() {
        
        // Get json
        var json = self.validArticleJSON
        
        // Remove required property
        json.removeValue(forKey: "source")
        
        // Parse
        let article = Article(json: json)
        
        // Assert
        XCTAssertNil(article, "Article should have been nil")
        
    }

    /// Test case where jsonInit is missing a required property
    func testJSONInit_missingRequired_title() {
        
        // Get json
        var json = self.validArticleJSON
        
        // Remove required property
        json.removeValue(forKey: "title")
        
        // Parse
        let article = Article(json: json)
        
        // Assert
        XCTAssertNil(article, "Article should have been nil")
        
    }
    
    /// Test case where jsonInit is missing a required property
    func testJSONInit_missingRequired_url() {
        
        // Get json
        var json = self.validArticleJSON
        
        // Remove required property
        json.removeValue(forKey: "url")
        
        // Parse
        let article = Article(json: json)
        
        // Assert
        XCTAssertNil(article, "Article should have been nil")
        
    }
    
    /// Test case where jsonInit is missing a required property
    func testJSONInit_missingRequired_publishedAt() {
        
        // Get json
        var json = self.validArticleJSON
        
        // Remove required property
        json.removeValue(forKey: "publishedAt")
        
        // Parse
        let article = Article(json: json)
        
        // Assert
        XCTAssertNil(article, "Article should have been nil")
        
    }
    
    /// Test case where jsonInit is missing all optional properties
    func testJSONInit_withMissingOptionals() {
        
        // Get json
        var json = self.validArticleJSON
        
        // Remove optional properties
        json.removeValue(forKey: "description")
        json.removeValue(forKey: "urlToImage")
        json.removeValue(forKey: "content")
        
        // Parse
        let article = Article(json: json)
        
        // Assert
        XCTAssertNotNil(article, "Article should not have been nil")
        
    }
    
}
