//
//  BlockchainInfoResponse.swift
//  BlockList
//
//  Created by Stephen Turton on 11/20/18.
//  Copyright © 2018 Stephen Turton. All rights reserved.
//

import Foundation

struct BlockchainInfoResponse : Codable {
    
    enum CodingKeys: String, CodingKey {
        case serverVersion = "server_version"
        case chainID = "chain_id"
        case headBlockNum = "head_block_num"
        case lastIrreversibleBlockNum = "last_irreversible_block_num"
        case lastIrreversibleBlockId = "last_irreversible_block_id"
        case headBlockId = "head_block_id"
        case headBlockTime = "head_block_time"
        case headBlockProducer = "head_block_producer"
        case virtualBlockCpuLimit = "virtual_block_cpu_limit"
        case virtualBlockNetLimit = "virtual_block_net_limit"
        case blockCpuLimit = "block_cpu_limit"
        case blockNetLimit = "block_net_limit"
        case serverVersionString = "server_version_string"
    }
    
    let serverVersion: String
    let chainID: String
    let headBlockNum: Int
    let lastIrreversibleBlockNum: Int
    let lastIrreversibleBlockId: String
    let headBlockId: String
    let headBlockTime: String
    let headBlockProducer: String
    let virtualBlockCpuLimit: Int
    let virtualBlockNetLimit: Int
    let blockCpuLimit: Int
    let blockNetLimit: Int 
    let serverVersionString: String
}

