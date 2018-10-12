//
//  ArticlePlaceholderTableViewCell.swift
//  News
//
//  Created by Thomas Valera on 10/10/2018.
//  Copyright © 2018 Valion. All rights reserved.
//

import UIKit

/// A UITableViewCell for an article placeholder
public class ArticlePlaceholderTableViewCell: UITableViewCell {

    //\////////////////////////////////////////
    // MARK: Public Properties
    //\////////////////////////////////////////

    /// The cell identifier
    public static let identifier = "ArticlePlaceholderTableViewCell"

    //\////////////////////////////////////////
    // MARK: Private Properties
    //\////////////////////////////////////////

    /* Add private properties here */

    //\////////////////////////////////////////
    // MARK: Outlets & Constraints
    //\////////////////////////////////////////

    @IBOutlet weak var imagePlaceholderView: UIView!
    @IBOutlet weak var titlePlaceholderView: UIView!
    @IBOutlet weak var infoPlaceholderView: UIView!

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

    /// Loads the layout of the cell
    private func loadLayout() {

        self.imagePlaceholderView.backgroundColor = UIColor.lightGray
        self.titlePlaceholderView.backgroundColor = UIColor.lightGray
        self.infoPlaceholderView.backgroundColor = UIColor.lightGray

    }
}
