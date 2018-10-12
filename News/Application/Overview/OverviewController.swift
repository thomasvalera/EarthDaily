//
//  OverviewController.swift
//  News
//
//  Created by Thomas Valera on 10/10/2018.
//  Copyright © 2018 Valion. All rights reserved.
//

import UIKit
import ValionKit

/// The controller for Overview
class OverviewController: ViewController {
    
    //\////////////////////////////////////////
    // MARK: Public Properties
    //\////////////////////////////////////////
    
    /// An array of articles currently loaded in the tableview
    private(set) var loadedArticles: [LoadedArticle] = []
    
    /// True if articles are loading, false otherwise.
    /// - Note: When true, the tableview will show placeholders instead of the actual articles
    private(set) var isLoading: Bool = false
    
    //\////////////////////////////////////////
    // MARK: Private Properties
    //\////////////////////////////////////////
    
    let presenter = OverviewPresenter()
    internal let navigator = OverviewNavigator()
    
    /// The number of placehodlers to show when loading articles
    let maxArticlePlaceholders = 15
    
    private let refreshControl = UIRefreshControl()
    
    //\////////////////////////////////////////
    // MARK: Outlets & Constraints
    //\////////////////////////////////////////
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var errorContainer: UIView!
    @IBOutlet weak var errorMessageLabel: UILabel!
    @IBOutlet weak var errorRetryButton: UIButton!
    
    //\////////////////////////////////////////
    // MARK: Initialization
    //\////////////////////////////////////////
    
    static func instantiate() -> OverviewController {
        // swiftlint:disable:next force_cast
        let controller = super.instantiate(identifier: "OverviewController", inStoryboardWithName: "Main") as! OverviewController
        
        return controller
        
    }
    
    //\////////////////////////////////////////
    // MARK: Load
    //\////////////////////////////////////////
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.presenter.attachView(view: self)
        self.navigator.attachViewController(controller: self)
        
    }
    
    /// This method is called when the controller's view has loaded.
    /// - Note: Use it to load as much frame-independant layout as the final frame is not yet known.
    override func preloadLayout() {
        super.preloadLayout()
        
        self.tableView.refreshControl = self.refreshControl
        refreshControl.addTarget(self, action: #selector(didPullToRefresh), for: .valueChanged)

        self.tableView.do {
            $0.delegate = self
            $0.dataSource = self
        }
        
        self.errorMessageLabel.do {
            $0.font = UIFont.montserratMedium(size: 16)
        }
        
        self.errorRetryButton.do {
            $0.setTitle("OverviewController_errorRetryButton_title".localized, for: .normal)
        }
        
        self.title = "OverviewController_title".localized
        
    }
    
    /// This method is called when the controller's view is about to be displayed.
    /// - Note: Use it to load the remaining part of the layout that depends on the final frame.
    override func loadLayout() {
        super.loadLayout()
    }
    
    override func viewDidAppearForTheFirstTime() {
        super.viewDidAppearForTheFirstTime()
        
        // Request headlines
        self.presenter.requestHeadlines()
    }
    
    //\////////////////////////////////////////
    // MARK: Memory Management
    //\////////////////////////////////////////
    
    deinit {
        // Unload stuff from memory such as images and any 
        // resources that might trigger a retain cycle.
        
        self.presenter.detachView()
        self.navigator.detachViewController()
        
        #if DEBUG_DEINIT
            print("Deinit OverviewController")
        #endif
    }
    
    //\////////////////////////////////////////
    // MARK: Actions
    //\////////////////////////////////////////
    
    @IBAction func errorRetryButtonPressed(_ sender: Any) {
        self.presenter.requestHeadlines()
    }
    
    @objc func didPullToRefresh() {
        self.presenter.requestHeadlines()
    }
    
}

/// Implements the view protocol for OverviewController
extension OverviewController: OverviewView {
    
    func loadArticlesPlaceholders() {
        
        // Hide eror and show tableview
        self.refreshControl.endRefreshing()
        self.errorContainer.isHidden = true
        self.tableView.isHidden = false
        
        self.isLoading = true
        
        // Register cells
        let nib = UINib(nibName: "ArticlePlaceholderTableViewCell", bundle: ValionKitHelper.bundle)
        self.tableView.register(nib, forCellReuseIdentifier: ArticlePlaceholderTableViewCell.identifier)
        
        self.tableView.reloadData()
    }
    
    func loadArticles(_ articles: [Article]) {
        
        self.isLoading = false
        
        // Register cells
        let nib = UINib(nibName: "ArticleTableViewCell", bundle: ValionKitHelper.bundle)
        self.tableView.register(nib, forCellReuseIdentifier: ArticleTableViewCell.identifier)
        
        // Load articles
        self.loadedArticles = articles.map({ (article) -> LoadedArticle in
            return LoadedArticle(withArticle: article)
        })
        
        self.tableView.reloadData()
        
    }
    
    func showError(_ message: String) {
        
        // Hide eror and show tableview
        self.refreshControl.endRefreshing()
        self.errorMessageLabel.text = message
        self.errorContainer.isHidden = false
        
        self.tableView.isHidden = true
        
    }
    
    func loadImage(_ image: UIImage, forArticle article: Article) {
        
        var loadedArticle: LoadedArticle?
        
        // Find loaded article
        for case let aLoadedArticle in self.loadedArticles where aLoadedArticle.article == article {
            loadedArticle = aLoadedArticle
            break
        }
        
        // Make sure cell is still there
        guard let cell = loadedArticle?.cell else {
            return
        }
        
        DispatchQueue.main.async {
            // Load image
            cell.previewImage = image
        }
        
    }
}

// A wrapper for a loaded article
class LoadedArticle {
    
    let article: Article
    private(set) var cell: ArticleTableViewCell?
    
    init(withArticle article: Article) {
        self.article = article
    }
    
    /// Loads the article in the given cell
    ///
    /// - Parameter cell: The cell to load in, nil to unload from currently loaded cell
    func load(inCell cell: ArticleTableViewCell?) {
        
        // Make sure cell exists
        guard let cell = cell else {
            // Else remove
            self.cell = nil
            return
        }
        
        self.cell = cell
        
        cell.do {
            $0.title = self.article.title
            $0.date = self.article.date.getReadableDate()
            $0.source = self.article.sourceName
        }
        
    }
}
