//
//  BlockResponseTests.swift
//  BlockListTests
//
//  Created by Stephen Turton on 11/20/18.
//  Copyright © 2018 Stephen Turton. All rights reserved.
//

import XCTest
@testable import BlockList

class BlockResponseTests: XCTestCase {

    var blockResponse: BlockResponse!
    
    override func setUp() {
        let data = loadStub(name: "get_block", extension: "json")
        let decoder = JSONDecoder()
        
        blockResponse = try!decoder.decode(BlockResponse.self, from: data)
    }

    override func tearDown() {
    }

   
    func testProducerIsSet() {
        XCTAssertEqual(blockResponse.producer,"eosflytomars")
    }

}
