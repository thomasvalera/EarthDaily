//
//  ArticleDetailController.swift
//  News
//
//  Created by Thomas Valera on 11/10/2018.
//  Copyright © 2018 Valion. All rights reserved.
//

import UIKit

/// The controller for ArticleDetail
class ArticleDetailController: ViewController {
    
    //\////////////////////////////////////////
    // MARK: Public Properties
    //\////////////////////////////////////////
    
    private(set) var article: Article!
    
    //\////////////////////////////////////////
    // MARK: Private Properties
    //\////////////////////////////////////////
    
    let presenter = ArticleDetailPresenter()
    internal  let navigator = ArticleDetailNavigator()
    
    //\////////////////////////////////////////
    // MARK: Outlets & Constraints
    //\////////////////////////////////////////
    
    /* Add outlets & constraints */
    @IBOutlet weak var topImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var infoSeparatorView: UIView!
    @IBOutlet weak var sourceLabel: UILabel!
    
    @IBOutlet weak var adTopSeparatorView: UIView!
    @IBOutlet weak var adButton: UIButton!
    @IBOutlet weak var adBottomSeparatorView: UIView!
    @IBOutlet weak var adImageView: UIImageView!
    
    @IBOutlet weak var contentLabel: UILabel!
    @IBOutlet weak var readMoreButton: UIButton!
    
    @IBOutlet weak var shadowView: UIView!
    
    //\////////////////////////////////////////
    // MARK: Initialization
    //\////////////////////////////////////////
    
    static func instantiate(withArticle article: Article) -> ArticleDetailController {
        // swiftlint:disable:next force_cast
        let controller = super.instantiate(identifier: "ArticleDetailController", inStoryboardWithName: "ArticleDetail") as! ArticleDetailController
        controller.article = article
        
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
        
        self.topImageView.image = UIImage.imagePlaceholder
        self.presenter.downloadImage(forArticle: self.article)
        
        self.titleLabel.do {
            $0.font = UIFont.merryweatherLight(size: 21)
            $0.textColor = UIColor.black
            $0.text = self.article.title
        }
        
        self.dateLabel.do {
            $0.font = UIFont.merryweatherLight(size: 12)
            $0.textColor = UIColor.gray
            $0.text = self.article.date.getReadableDate()
        }
        
        self.sourceLabel.do {
            $0.font = UIFont.merryweatherLight(size: 12)
            $0.textColor = UIColor.riverBlue
            $0.text = self.article.sourceName
        }
        
        self.adImageView.image = UIImage.adImage
        
        self.infoSeparatorView.backgroundColor = UIColor.lightGray
        self.adTopSeparatorView.backgroundColor = UIColor.lightGray
        self.adBottomSeparatorView.backgroundColor = UIColor.lightGray
        
        self.descriptionLabel.do {
            
            $0.font = UIFont.montserratMedium(size: 16)
            $0.textColor = UIColor.black
            $0.text = self.article.description
            
        }
        
        self.contentLabel.do {
            $0.font = UIFont.montserratLight(size: 14)
            $0.textColor = UIColor.black
            
            var text: String? = self.article.content
            let components = self.article.content?.components(separatedBy: "[+")
            
            // Remove [+...] part of the content if possible
            if let components = components, components.count > 1 {
                text = components[0]
            }
            
            $0.text = text
        }
        
        self.readMoreButton.do {
            let format = "ArticleDetailController_buttonReadMore".localized
            let title = String(format: format, self.article.sourceName)
            $0.setTitle(title, for: .normal)
        }
        
    }
    
    /// This method is called when the controller's view is about to be displayed.
    /// - Note: Use it to load the remaining part of the layout that depends on the final frame.
    override func loadLayout() {
        super.loadLayout()
    }
    
    //\////////////////////////////////////////
    // MARK: Memory Management
    //\////////////////////////////////////////
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    deinit {
        // Unload stuff from memory such as images and any
        // resources that might trigger a retain cycle.
        
        self.presenter.detachView()
        self.navigator.detachViewController()
        
        #if DEBUG_DEINIT
        print("Deinit ArticleDetailController")
        #endif
    }
    
    //\////////////////////////////////////////
    // MARK: Actions
    //\////////////////////////////////////////
    
    @IBAction func readMoreButtonPressed(_ sender: Any) {
        self.navigator.openBrowser(forUrl: self.article.url)
    }
    
    @IBAction func addButtonPressed(_ sender: Any) {
        self.navigator.showPremiumUpgradeScreen()
    }
    
    //\////////////////////////////////////////
    // MARK: Methods
    //\////////////////////////////////////////
    
    /* Add methods */
    
}

/// Implements the view protocol for ArticleDetailController
extension ArticleDetailController: ArticleDetailView {
    
    //\////////////////////////////////////////
    // MARK: Methods
    //\////////////////////////////////////////
    
    func loadImage(_ image: UIImage, forArticle article: Article) {
    
        self.topImageView.image = image
        
    }
    
}
