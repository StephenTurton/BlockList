//
//  BlockData.swift
//  BlockList
//
//  Created by Stephen Turton on 11/20/18.
//  Copyright © 2018 Stephen Turton. All rights reserved.
//

import Foundation

protocol BlockData {
    
    var blockNumber: Int { get }
    
    var producer: String { get }
    
    var transactionCount: Int { get }
    
    var signature: String { get }
    
    var data: Data? { get }
}
