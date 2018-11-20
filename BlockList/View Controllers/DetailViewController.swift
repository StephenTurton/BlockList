//
//  DetailViewController.swift
//  BlockList
//
//  Created by Stephen Turton on 11/20/18.
//  Copyright © 2018 Stephen Turton. All rights reserved.
//

import UIKit

final class DetailViewController: UIViewController {

    @IBOutlet weak var producer: UILabel!
    
    @IBOutlet weak var transactionCount: UILabel!
    
    @IBOutlet weak var signature: UILabel!
    
    @IBOutlet weak var summaryStackView: UIStackView!
    
    @IBOutlet weak var rawTextView: UITextView!
    
    var viewModel: BlockDetailViewModel? {
        didSet {
            guard let viewModel = viewModel else {
                return
            }
            
            setupViewModel(with: viewModel)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func summaryButtonClicked(_ sender: Any) {
        summaryStackView.isHidden = false
        rawTextView.isHidden = true
    }
    
    @IBAction func rawButtonClicked(_ sender: Any) {
        summaryStackView.isHidden = true
        rawTextView.isHidden = false
    }
    
    private func setupViewModel(with viewModel: BlockDetailViewModel) {
        title = viewModel.title
        producer.text = viewModel.producer
        transactionCount.text = viewModel.transactionCount
        signature.text = viewModel.signature
        rawTextView.text = viewModel.rawText
    }
}
