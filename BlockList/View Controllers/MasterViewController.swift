//
//  MasterViewController.swift
//  BlockList
//
//  Created by Stephen Turton on 11/20/18.
//  Copyright © 2018 Stephen Turton. All rights reserved.
//

import UIKit

final class MasterViewController: UIViewController {

    private enum AlertType {
        case noDataAvailable
    }
    
    fileprivate var collapseDetailViewController = true
    
    var viewModel: BlockListViewModel? {
        didSet {
            guard let viewModel = viewModel else {
                return
            }
            
            setupViewModel(with: viewModel)
        }
    }
    
    @IBOutlet weak var tableView: UITableView!
    
    @IBOutlet weak var refreshButton: UIButton!
    
    @IBOutlet var activityIndicatorView: UIActivityIndicatorView! {
        didSet {
            activityIndicatorView.startAnimating()
            activityIndicatorView.hidesWhenStopped = true
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        splitViewController?.delegate = self
        
        title = "Block List"
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        guard let navController = segue.destination as? UINavigationController,
            let viewController = navController.topViewController as? DetailViewController else {
                fatalError("Expected DetailViewController")
        }
        
        collapseDetailViewController = false
        
        viewController.navigationItem.leftBarButtonItem = splitViewController?.displayModeButtonItem
        viewController.navigationItem.leftItemsSupplementBackButton = true
        
        if let indexPath = tableView.indexPathForSelectedRow {
            viewController.loadViewIfNeeded()
            if let block = viewModel?.block(at:indexPath.row) {
                viewController.viewModel = BlockDetailViewModel(block:block)
            }
        }
    }
    
    @IBAction func refreshButtonClicked(_ sender: Any) {
        
        viewModel?.refresh()
        activityIndicatorView.startAnimating()
        refreshButton.isEnabled = false
        
        if let navigationController = self.splitViewController?.viewControllers.last as? UINavigationController {
            if let viewController = navigationController.topViewController as? DetailViewController {
                viewController.viewModel = nil
            }
        }
    }
    
    private func setupViewModel(with viewModel: BlockListViewModel) {
        viewModel.didUpdateBlockList = { [weak self] (error) in
            if let _ = error {
                self?.presentAlert(of: .noDataAvailable)
                self?.refreshButton.isEnabled = true
            } else {
                self?.activityIndicatorView.stopAnimating()
                self?.tableView.reloadData()
                self?.refreshButton.isEnabled = true
            }
        }
    }
    
    private func presentAlert(of alertType: AlertType) {
        
        activityIndicatorView.stopAnimating()
        
        let title: String
        let message: String
        
        switch alertType {
        case .noDataAvailable:
            title = "Unable to fetch Blockchain List"
            message = "The application is unable to fetch the blockchain data. Please make sure your device is connected over Wi-Fi or cellular."
        }
        
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let cancelAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
        alertController.addAction(cancelAction)
        
        present(alertController, animated: true)
    }
}

extension MasterViewController: UISplitViewControllerDelegate {
    
    func splitViewController(_ splitViewController: UISplitViewController, collapseSecondary secondaryViewController: UIViewController, onto primaryViewController: UIViewController) -> Bool {
        return collapseDetailViewController
    }
}

extension MasterViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.performSegue(withIdentifier: "showBlockDetailSegue", sender: self)
    }
}

extension MasterViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: BlockItemTableViewCell.reuseIdentifier, for: indexPath) as? BlockItemTableViewCell else {
            fatalError("Unable to Dequeue BlockItemTableViewCell")
        }
        
        let block = viewModel?.block(at:indexPath.row)
        cell.blockNameLabel.text = "Block \(block?.blockNumber ?? 0)"
        cell.accessoryType = .disclosureIndicator
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel?.blockCount ?? 0
    }
}

