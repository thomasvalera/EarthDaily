//
//  ArticleTableViewCell.swift
//  News
//
//  Created by Thomas Valera on 10/10/2018.
//  Copyright © 2018 Valion. All rights reserved.
//

import UIKit
import Then

/// A UITableViewCell for an article
public class ArticleTableViewCell: UITableViewCell {

    //\////////////////////////////////////////
    // MARK: Public Properties
    //\////////////////////////////////////////
    
    /// The cell identifier
    public static let identifier = "ArticleTableViewCell"
    
    /// The title of the article
    public var title: String? = nil {
        didSet { self.titleLabel.text = self.title }
    }
    
    /// The date of the article
    public var date: String? = nil {
        didSet { self.dateLabel.text = self.date}
    }
    
    /// The source of the article
    public var source: String? = nil {
        didSet { self.sourceLabel.text = self.source}
    }
    
    /// The image of the article
    public var previewImage: UIImage? = nil {
        didSet { self.previewImageView.image = self.previewImage }
    }
    
    //\////////////////////////////////////////
    // MARK: Private Properties
    //\////////////////////////////////////////
    
    /* Add private properties here */
    
    //\////////////////////////////////////////
    // MARK: Outlets & Constraints
    //\////////////////////////////////////////
    
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var previewImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var infoSeparatorView: UIView!
    @IBOutlet weak var sourceLabel: UILabel!
    
    //\////////////////////////////////////////
    // MARK: - Initialization
    //\////////////////////////////////////////
    
    override public func awakeFromNib() {
        super.awakeFromNib()
        
        self.loadLayout()
    }
    
    override public func prepareForReuse() {
        super.prepareForReuse()
        
        // Reload default layout
        self.loadLayout()
    }
    
    //\////////////////////////////////////////
    // MARK: - Layout
    //\////////////////////////////////////////
    
    override public func setSelected(_ selected: Bool, animated: Bool) {
        // Disables the selected state
    }
    
    override public func setHighlighted(_ highlighted: Bool, animated: Bool) {
        self.containerView.backgroundColor = highlighted ? UIColor.lightText : UIColor.white
    }
    
    /// Loads the layout of the cell
    private func loadLayout() {
        
        self.titleLabel.do {
            $0.font = UIFont.merryweatherLight(size: 16)
            $0.textColor = UIColor.black
        }
        
        self.dateLabel.do {
            $0.font = UIFont.montserratMedium(size: 12)
            $0.textColor = UIColor.gray
        }
        
        self.sourceLabel.do {
            $0.font = UIFont.montserratMedium(size: 12)
            $0.textColor = UIColor.riverBlue
        }
        
        self.infoSeparatorView.backgroundColor = UIColor.lightGray
        
        self.previewImageView.image = UIImage.imagePlaceholder
    }
}
