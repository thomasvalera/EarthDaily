//
//  UIImage+Images.swift
//  News
//
//  Created by Thomas Valera on 11/10/2018.
//  Copyright © 2018 Valion. All rights reserved.
//

/// An extension of UIImage
extension UIImage {
    
    //\////////////////////////////////////////
    // MARK: - Methods
    //\////////////////////////////////////////
    
    public static var imagePlaceholder: UIImage {
        return UIImage(named: "imagePlaceholder", in: ValionKitHelper.bundle, compatibleWith: nil)!
    }
    
    public static var adImage: UIImage {
        return UIImage(named: "adImage", in: ValionKitHelper.bundle, compatibleWith: nil)!
    }
    
}
