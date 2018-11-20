//
//  BlockListViewModel.swift
//  BlockList
//
//  Created by Stephen Turton on 11/20/18.
//  Copyright © 2018 Stephen Turton. All rights reserved.
//

import Foundation

class BlockListViewModel {
    
    private let eosAPI = {
        return EosAPI()
    }()
    
    private var blocks = [BlockResponse]()
    
    private var defaultBlockCount = 20
    
    typealias DidUpdateBlockListCompletion = ((_ error: EosAPI.EosAPIError?) -> ())
    var didUpdateBlockList: DidUpdateBlockListCompletion? = nil
    
    init() {
        fetchBlockList()
    }
    
    private func fetchBlockList() {
        
        if blocks.count > 0 {
            blocks.removeAll()
            didUpdateBlockList?(nil)
        }
        
        eosAPI.didFetchBlockData = { [weak self] (blockResponse, error) in
            
            DispatchQueue.main.async {
                
                if let error = error {
                    self?.didUpdateBlockList?(error)
                } else {
                    if let blockResponse = blockResponse {
                        self?.blocks.append(blockResponse)
                    } else {
                        self?.didUpdateBlockList?(nil)
                    }
                }
            }
        }
        
        eosAPI.getMostRecentBlocks(limit: defaultBlockCount)
    }
}
