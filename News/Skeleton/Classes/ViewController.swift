//
//  ViewController.swift
//  News
//
//  Created by Thomas Valera on 10/10/2018.
//  Copyright © 2018 Valion. All rights reserved.
//

import UIKit

/// The superclass of all custom view controllers
class ViewController: UIViewController {
    
    //\////////////////////////////////////////
    // MARK: Public properties
    //\////////////////////////////////////////
    
    // True if view already appeared once, false otherwise
    private(set) var didAppear: Bool = false
    
    //\////////////////////////////////////////
    // MARK: Private Properties
    //\////////////////////////////////////////
    
    /** Add private properties here */
    
    //\////////////////////////////////////////
    // MARK: Initialization
    //\////////////////////////////////////////
    
    static func instantiate(identifier: String, inStoryboardWithName storyboardName: String) -> ViewController {
        //swiftlint:disable:next force_cast
        return UIStoryboard(name: storyboardName, bundle: nil).instantiateViewController(withIdentifier: identifier) as! ViewController
    }
    
    //\////////////////////////////////////////
    // MARK: Load
    //\////////////////////////////////////////
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        self.preloadLayout()
        
    }
    
    /// This method is called when the controller's view has loaded.
    /// - Note: Use it to load as much frame-independant layout as the final frame is not yet known.
    func preloadLayout() {}
    
    /// This method is called when the controller's view is about to be displayed.
    /// - Note: Use it to load the remaining part of the layout that depends on the final frame.
    func loadLayout() {}
    
    //\////////////////////////////////////////
    // MARK: Memory Management
    //\////////////////////////////////////////
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    deinit {
        // This method will automatically be called when the controller gets de-initialized
        // Use this to unload stuff from memory
        
        #if DEBUG_DEINIT
            print("Deinit ViewController")
        #endif
    }
    
    //\////////////////////////////////////////
    // MARK: Appear Methods
    //\////////////////////////////////////////
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        // If first time
        if self.didAppear == false {
            self.viewWillAppearForTheFirstTime()
        }
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        // If first time
        if self.didAppear == false {
            self.viewDidAppearForTheFirstTime()
        }
    }
    
    /// Called when the view is about to appear for the first time
    func viewWillAppearForTheFirstTime() {
        self.loadLayout()
    }
    
    /// Called when the view has appears for the first time
    func viewDidAppearForTheFirstTime() {
        self.didAppear = true
    }
    
    //\////////////////////////////////////////
    // MARK: Methods
    //\////////////////////////////////////////
    
    /** Add your methods here */
    
    //\////////////////////////////////////////
    // MARK: Orientation
    //\////////////////////////////////////////
    
    override var shouldAutorotate: Bool {
        return true
    }
    
    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        return UIInterfaceOrientationMask.all
    }
    
    override var preferredInterfaceOrientationForPresentation: UIInterfaceOrientation {
        return UIInterfaceOrientation.portrait
    }
}
