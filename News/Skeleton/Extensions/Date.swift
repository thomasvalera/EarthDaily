//
//  NSDate.swift
//  Valion
//
//  Created by Thomas Valera [Valion] on 04/10/15.
//  Copyright © 2016 Thomas Valera [Valion]. All rights reserved.
//

import Foundation

extension Date {
    
    //\////////////////////////////////////////
    // MARK: Initialization
    //\////////////////////////////////////////
    
    init(withString string: String, format: String = "yyyy-MM-dd HH:mm:ss") {
        
        let dateFormatter = DateFormatter()
        
        dateFormatter.dateFormat = format
        if let theDate = dateFormatter.date(from: string) {
            
            self.init(timeInterval: 0, since: theDate)
            
        } else {
            self.init()
        }
        
    }
    
    init(withISO8601String string: String) {
        
        self.init(withString: string, format: "yyyy-MM-dd'T'HH:mm:ssZZZZZ")
        
    }
    
    //\////////////////////////////////////////
    // MARK: Methods
    //\////////////////////////////////////////
    
    func getReadableDate(optionalFormat format: String = "dd-MM-yyyy") -> String {
        
        let formatter = DateFormatter()
        
        formatter.dateFormat = format
        
        return formatter.string(from: self)
        
    }
    
}
