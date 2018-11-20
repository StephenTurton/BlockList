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
    
    private var blocks = [BlockData]()
    
    private var defaultBlockCount = 20
    
    typealias DidUpdateBlockListCompletion = ((_ error: EosAPI.EosAPIError?) -> ())
    var didUpdateBlockList: DidUpdateBlockListCompletion? = nil
    
    var blockCount: Int {
        return blocks.count
    }
    
    init() {
        fetchBlockList()
    }
    
    func block(at index: Int) -> BlockData? {
        guard index >= 0 && index < blockCount else {
            return nil
        }
        return blocks[index]
    }
    
    public func refresh() {
        if blocks.count > 0 {
            blocks.removeAll()
            didUpdateBlockList?(nil)
        }
        fetchBlockList()
    }
    
    private func fetchBlockList() {
        
        if blocks.count > 0 {
            blocks.removeAll()
            didUpdateBlockList?(nil)
        }
        
        eosAPI.didFetchBlockData = { [weak self] (blockData, error) in
            
            DispatchQueue.main.async {
                
                if let error = error {
                    self?.didUpdateBlockList?(error)
                } else {
                    if let blockData = blockData {
                        self?.blocks.append(blockData)
                    } else {
                        self?.didUpdateBlockList?(nil)
                    }
                }
            }
        }
        
        eosAPI.getMostRecentBlocks(limit: defaultBlockCount)
    }
}
