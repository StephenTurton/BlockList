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
    
    @IBOutlet weak var summaryButton: UIButton!
    
    @IBOutlet weak var rawButton: UIButton!
    
    var viewModel: BlockDetailViewModel? {
        didSet {
            guard let viewModel = viewModel else {
                setupView()
                return
            }
            
            setupViewModel(with: viewModel)
            setupView()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupView()
    }
    
    @IBAction func summaryButtonClicked(_ sender: Any) {
        summaryStackView.isHidden = false
        rawTextView.isHidden = true
    }
    
    @IBAction func rawButtonClicked(_ sender: Any) {
        summaryStackView.isHidden = true
        rawTextView.isHidden = false
    }

    private func setupView() {
        
        guard let _ = viewModel else {
            title = ""
            producer.isHidden = true
            transactionCount.isHidden = true
            signature.isHidden = true
            rawTextView.isHidden = true
            
            summaryButton.isEnabled = false
            rawButton.isEnabled = false
            return
        }
        
        producer.isHidden = false
        transactionCount.isHidden = false
        signature.isHidden = false
        summaryButton.isEnabled = true
        rawButton.isEnabled = true
    }
    
    private func setupViewModel(with viewModel: BlockDetailViewModel) {
        title = viewModel.title
        producer.text = viewModel.producer
        transactionCount.text = viewModel.transactionCount
        signature.text = viewModel.signature
        rawTextView.text = viewModel.rawText
    }
}
