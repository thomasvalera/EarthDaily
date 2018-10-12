//
//  OverviewNavigatorSpy.swift
//  News
//
//  Created by Thomas Valera on 11/10/2018.
//  Copyright © 2018 Valion. All rights reserved.
//

@testable import News

/// A spy of OverviewNavigator
class OverviewNavigatorSpy: OverviewNavigator {

    //\////////////////////////////////////////
    // MARK: Trackers
    //\////////////////////////////////////////

    private(set) var loadArticlesPlaceholdersCalled = 0

    //\////////////////////////////////////////
    // MARK: Methods
    //\////////////////////////////////////////

    override func goToDetail(forArticle article: Article) {

        loadArticlesPlaceholdersCalled += 1

    }

}
