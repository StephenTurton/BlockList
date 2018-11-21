//
//  DetailViewControllerTests.swift
//  BlockListTests
//
//  Created by Stephen Turton on 11/21/18.
//  Copyright © 2018 Stephen Turton. All rights reserved.
//

import XCTest
@testable import BlockList

class DetailViewControllerTests: XCTestCase {

    var viewController: DetailViewController!
    
    override func setUp() {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        viewController = storyboard.instantiateViewController(
            withIdentifier: "DetailViewController") as? DetailViewController
        viewController?.loadViewIfNeeded()
    }
    
    func testTitleIsEmptyWehenNoViewModelIsSet() {
        XCTAssertEqual(viewController?.navigationItem.title, "")
    }
    
    func testLabelControlsHiddenWenNoViewModelIsSet() {
        
        let controlsHidden = viewController?.viewModel == nil &&
            viewController?.producer.isHidden == true &&
            viewController?.transactionCount.isHidden == true &&
            viewController?.signature.isHidden == true
        
        XCTAssertTrue(controlsHidden, "Label Controls should be hidden if no viewModel is set")
    }
    
    func testLabelsHaveCorrectTextWhenViewModelIsSet() {
        let data = loadStub(name: "get_block", extension: "json")
        let decoder = JSONDecoder()
        let blockResponse = try!decoder.decode(BlockResponse.self, from: data)
      
        let viewModel = BlockDetailViewModel(block:blockResponse)
        viewController?.viewModel = viewModel
        
        XCTAssertEqual(viewController?.transactionCount.text, "Transactions: 48")
        XCTAssertEqual(viewController?.producer.text, "Producer: eosflytomars")
        XCTAssertEqual(viewController?.signature.text, "Signature: SIG_K1_K37MrhwanKtwSXx3kk61RsvjgNfN35bvLCHJ5MtHBYrSaaUxGtFKubZbSo3hPwoUZQ4LsTXAxeD9VHFRPM1fEzZdjB7Bwt")
    }
    
    func testSummaryButtonDisabledWehenNoViewModelIsSet() {
        XCTAssertTrue(viewController?.viewModel == nil && viewController?.summaryButton.isEnabled == false, "Summary Button Should be disabled when we have no view model")
    }
    
    func testRawButtonDisabledWehenNoViewModelIsSet() {
        XCTAssertTrue(viewController?.viewModel == nil && viewController?.rawButton.isEnabled == false, "Summary Button Should e hidden")
    }
}
