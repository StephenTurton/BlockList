//
//  BlockchainInfoResponseTests.swift
//  BlockListTests
//
//  Created by Stephen Turton on 11/20/18.
//  Copyright © 2018 Stephen Turton. All rights reserved.
//

import XCTest
@testable import BlockList

class BlockchainInfoResponseTests: XCTestCase {

    var infoResponse: BlockchainInfoResponse!
    
    override func setUp() {
        super.setUp()
        
        let data = loadStub(name: "get_info", extension: "json")
        let decoder = JSONDecoder()
        
        infoResponse = try!decoder.decode(BlockchainInfoResponse.self, from: data)
    }
    
    override func tearDown() {
    }
    
    func testHeadBlockNumerIsSet() {
        XCTAssertEqual(infoResponse.headBlockNum,28002626)
    }
}
