//
//  MasterViewControllerTests.swift
//  BlockListTests
//
//  Created by Stephen Turton on 11/21/18.
//  Copyright © 2018 Stephen Turton. All rights reserved.
//

import XCTest
@testable import BlockList

class MasterViewControllerTests: XCTestCase {

    func testTitleIsBlockList() {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let viewController = storyboard.instantiateViewController(
            withIdentifier: "MasterViewController")
        viewController.loadViewIfNeeded()
        XCTAssertEqual(viewController.navigationItem.title, "Block List")
    }
    
    func testTableViewDelegatesAreSet() {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let viewController = storyboard.instantiateViewController(
            withIdentifier: "MasterViewController") as? MasterViewController
        viewController?.loadViewIfNeeded()
        XCTAssertTrue(viewController?.tableView.delegate != nil)
        XCTAssertTrue(viewController?.tableView.dataSource != nil)
    }
}
