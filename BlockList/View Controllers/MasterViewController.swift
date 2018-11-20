//
//  MasterViewController.swift
//  BlockList
//
//  Created by Stephen Turton on 11/20/18.
//  Copyright © 2018 Stephen Turton. All rights reserved.
//

import UIKit

final class MasterViewController: UIViewController {

    fileprivate var collapseDetailViewController = true
    
    override func viewDidLoad() {
        super.viewDidLoad()
        splitViewController?.delegate = self
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        guard let navController = segue.destination as? UINavigationController,
            let viewController = navController.topViewController as? DetailViewController else {
                fatalError("Expected DetailViewController")
        }
        
        collapseDetailViewController = false
        
        viewController.navigationItem.leftBarButtonItem = splitViewController?.displayModeButtonItem
        viewController.navigationItem.leftItemsSupplementBackButton = true
    }
}

extension MasterViewController: UISplitViewControllerDelegate {
    
    func splitViewController(_ splitViewController: UISplitViewController, collapseSecondary secondaryViewController: UIViewController, onto primaryViewController: UIViewController) -> Bool {
        
        // Return true to prevent the default of showing the secondary
        // view controller.
        return collapseDetailViewController
    }
}

extension MasterViewController: UITableViewDelegate {
}

extension MasterViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 0
    }
}

