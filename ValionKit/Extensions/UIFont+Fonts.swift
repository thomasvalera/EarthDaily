//
//  UIFont+Fonts.swift
//  News
//
//  Created by Thomas Valera on 10/10/2018.
//  Copyright © 2018 Valion. All rights reserved.
//

import UIKit

/// An extension of UIFont
public extension UIFont {
    
    //\////////////////////////////////////////
    // MARK: - Properties
    //\////////////////////////////////////////
    
    // Font names
    private static let montserratMediumFontName = "Montserrat-Medium"
    private static let montserratLightFontName = "Montserrat-Light"
    private static let merryweatherLightFontName = "Merriweather-Light"
    
    //\////////////////////////////////////////
    // MARK: Methods
    //\////////////////////////////////////////
    
    /**
     Prints all the project's font names.
     
     NOTE: File name and actual font name can be different when importing custom fonts in the project.
     */
    static func printAllFontNames() {
        for name in UIFont.familyNames {
            print(name)
            print(UIFont.fontNames(forFamilyName: name))
        }
    }
    
    /// Gets the Montserrat medium font
    ///
    /// - Note: Use this font for article descriptions
    /// - Parameter size: The size of the font
    /// - Returns: The font
    public static func montserratMedium(size: CGFloat) -> UIFont? {
        return UIFont(name: montserratMediumFontName, size: size)
    }
    
    /// Gets the Montserrat light font
    ///
    /// - Note: Use this font for article contents
    /// - Parameter size: The size of the font
    /// - Returns: The font
    public static func montserratLight(size: CGFloat) -> UIFont? {
        return UIFont(name: montserratLightFontName, size: size)
    }
    
    /// Gets the Merryweather light font
    ///
    /// - Note: Use this font for article titles
    /// - Parameter size: The size of the font
    /// - Returns: The font
    public static func merryweatherLight(size: CGFloat) -> UIFont? {
        return UIFont(name: montserratMediumFontName, size: size)
    }
    
}
