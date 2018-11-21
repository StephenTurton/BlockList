//
//  AppDelegate.swift
//  BlockList
//
//  Created by Stephen Turton on 11/20/18.
//  Copyright © 2018 Stephen Turton. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        //Setup SplitViewController and inject BlockListViewModel into the MasterView
        if let splitViewController = self.window?.rootViewController as? UISplitViewController {
            splitViewController.preferredDisplayMode = .allVisible
            
            if let splitViewController = self.window?.rootViewController as? UISplitViewController {
                splitViewController.preferredDisplayMode = .allVisible
                
                if let navigationController = splitViewController.viewControllers.last as? UINavigationController {
                    navigationController.topViewController?.navigationItem.leftBarButtonItem = splitViewController.displayModeButtonItem
                }
                
                if let navigationController = splitViewController.viewControllers.first as? UINavigationController {
                    if let masterViewController = navigationController.viewControllers.first as? MasterViewController {
                        masterViewController.viewModel = BlockListViewModel()
                    }
                }
            }
        }
        
        return true
    }
}

