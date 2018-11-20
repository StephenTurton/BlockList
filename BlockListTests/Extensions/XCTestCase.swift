//
//  XCTestCase.swift
//  BlockListTests
//
//  Created by Stephen Turton on 11/20/18.
//  Copyright © 2018 Stephen Turton. All rights reserved.
//

import XCTest

extension XCTestCase {
    func loadStub(name: String, extension: String) -> Data {
        let bundle = Bundle(for: classForCoder)
        let url = bundle.url(forResource: name,withExtension:`extension`)
        
        return try! Data(contentsOf: url!)
    }
    
}
