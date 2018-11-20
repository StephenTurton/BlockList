//
//  BlockDetailViewModel.swift
//  BlockList
//
//  Created by Stephen Turton on 11/20/18.
//  Copyright © 2018 Stephen Turton. All rights reserved.
//

import Foundation

struct BlockDetailViewModel {
 
    var block: BlockData
    
    var title: String {
        return "Block: \(block.blockNumber)"
    }
    
    var producer: String {
        return "Producer: \(block.producer)"
    }
    
    var transactionCount: String {
        return "Transactions: \(block.transactionCount)"
    }
    
    var signature: String {
        return "Signature: \(block.signature)"
    }
    
    var rawText: String? {
        
        guard let data = block.data else {
            return nil
        }
        
        let jsonResponse = try? JSONSerialization.jsonObject(with: data, options: [])
        if let response = jsonResponse as? [String: Any] {
            return "\(response)"
        }
        
        return nil
    }
}
