//
//  String.swift
//  Valion
//
//  Created by Thomas Valera [Valion] on 04/10/15.
//  Copyright © 2016 Thomas Valera [Valion]. All rights reserved.
//

import Foundation

extension String {
    
    //\////////////////////////////////////////
    // MARK: Properties
    //\////////////////////////////////////////
    
    /// Returns the localized version of itself
    public var localized: String {
        return NSLocalizedString(self, comment: "")
    }
    
}
