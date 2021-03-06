//
//  BlockResponse.swift
//  BlockList
//
//  Created by Stephen Turton on 11/20/18.
//  Copyright © 2018 Stephen Turton. All rights reserved.
//

import Foundation

//Model used to store results of a Block for example results
//from the /chain/get_block route

struct BlockResponse : Codable {
    
    struct Transaction: Codable {
        struct TransactionDetail: Codable {
            enum CodingKeys: String, CodingKey {
                case id = "id"
            }
            
            let id: String
        }
        
        enum CodingKeys: String, CodingKey {
            case trx = "trx"
        }
        
        var trx: String?
        var trxDetail: TransactionDetail?
        
        init(from decoder: Decoder) throws {
            let values = try decoder.container(keyedBy: CodingKeys.self)
            trx = try? values.decode(String.self, forKey: .trx)
            if trx == nil {
                trxDetail = try values.decode(TransactionDetail.self, forKey: .trx)
            }
        }
    }
    
    enum CodingKeys: String, CodingKey {
        case timestamp = "timestamp"
        case producer = "producer"
        case previous = "previous"
        case producerSignature = "producer_signature"
        case blockNumber = "block_num"
        case transactions = "transactions"
    }
    
    let timestamp: String
    let producer: String
    let previous: String
    let producerSignature: String
    let blockNumber: Int
    let transactions: [Transaction]
    
    var data: Data?
}

extension BlockResponse: BlockData {
    var transactionCount: Int {
        return transactions.count
    }
    
    var signature: String {
        return producerSignature
    }
}

