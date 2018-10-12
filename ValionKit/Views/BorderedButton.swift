//
//  BorderedButton.swift
//  News
//
//  Created by Thomas Valera on 11/10/2018.
//  Copyright © 2018 Valion. All rights reserved.
//

import UIKit
import Then

/// A button with borders
public class BorderedButton: UIButton {
    
    //\////////////////////////////////////////
    // MARK: Public Properties
    //\////////////////////////////////////////
    
    override public var isHighlighted: Bool {
        didSet { self.loadLayout() }
    }
    
    //\////////////////////////////////////////
    // MARK: Private Properties
    //\////////////////////////////////////////
    
    /* Add private properties here */
    
    //\////////////////////////////////////////
    // MARK: IBOutlets & Constants
    //\////////////////////////////////////////
    
    @IBOutlet var contentView: UIView!
    
    //\////////////////////////////////////////
    // MARK: Initialization
    //\////////////////////////////////////////
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }
    
    override public func prepareForInterfaceBuilder() {
        super.prepareForInterfaceBuilder()
        commonInit()
    }
    
    /// A common method called by all initializers.
    /// This will take care of loading the view properly.
    private func commonInit() {
        
        /* Load common properties */
 
        self.loadLayout()
    }
    
    deinit {
        // Unload stuff from memory such as images and any
        // resources that might trigger a retain cycle.
        
        #if DEBUG_DEINIT
        print("Deinit BorderedButton")
        #endif
    }
    
    //\////////////////////////////////////////
    // MARK: Tracking
    //\////////////////////////////////////////
    
    public override func beginTracking(_ touch: UITouch, with event: UIEvent?) -> Bool {
        
        // If touch started
        if event?.type == .touches {
            self.isHighlighted = true
        }
        
        return true
    }
    
    public override func endTracking(_ touch: UITouch?, with event: UIEvent?) {
        
        // If touch ended
        if event?.type == .touches {
            self.isHighlighted = false
        }
        
    }
    
    //\////////////////////////////////////////
    // MARK: Layout
    //\////////////////////////////////////////
    func loadLayout() {
        
        self.do {
            $0.layer.borderWidth = 1
            $0.layer.borderColor = UIColor.riverBlue.cgColor
            $0.layer.cornerRadius = $0.frame.size.height / 2
            
            $0.setTitleColor(UIColor.white, for: .highlighted)
            $0.setTitleColor(UIColor.riverBlue, for: .normal)
            
            $0.backgroundColor = self.isHighlighted ? UIColor.riverBlue : UIColor.clear
            
            $0.titleLabel?.font = UIFont.montserratMedium(size: 16)
            
        }
        
    }
    
}
