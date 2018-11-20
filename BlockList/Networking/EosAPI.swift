//
//  EosAPI.swift
//  BlockList
//
//  Created by Stephen Turton on 11/20/18.
//  Copyright © 2018 Stephen Turton. All rights reserved.
//

import Foundation

private enum BlockOneService {
    static let baseUrl = URL(string:"https://api.eosnewyork.io/v1")
}


class EosAPI {
    
    enum EosAPIError: Error {
        case noDataAvailable
    }
    
    typealias DidFetchBlockDataCompletion = (BlockResponse?, EosAPIError?) -> Void
    
    private var getInfoUrl: URL? {
        return BlockOneService.baseUrl?.appendingPathComponent("/chain/get_info")
    }
    
    private var getBlockUrl: URL? {
        return BlockOneService.baseUrl?.appendingPathComponent("/chain/get_block")
    }
    
    var didFetchBlockData: DidFetchBlockDataCompletion? = nil
    
    func getMostRecentBlocks(limit: Int) {
        
        getHeadBlock(completion: { [weak self] (response, error) in
            if error == nil {
                let previous = response?.previous ?? ""
                if previous != "" {
                    self?.getBlockList(startBlockId:previous, total:0, limit:limit)
                }
            } else {
                self?.didFetchBlockData?(nil, .noDataAvailable)
            }
        })
    }
    
    func getBlockList(startBlockId id: String, total: Int, limit: Int) {
        
        guard total <= limit else {
            didFetchBlockData?(nil,nil)
            return
        }
        
        getBlock(for: id, completion: { [weak self] (response, error) in
            
            guard error == nil else {
                self?.didFetchBlockData?(nil,nil)
                return
            }
            
            if let response = response {
                
                DispatchQueue.main.async {
                    self?.didFetchBlockData?(response,nil)
                }
                
                let previous = response.previous
                self?.getBlockList(startBlockId:previous,total:total+1,limit:limit)
            }
        })
    }
    
    
    func getHeadBlock(completion: @escaping DidFetchBlockDataCompletion) {
        
        guard let url = getInfoUrl else {
            return
        }
        
        URLSession.shared.dataTask(with: url) { [weak self] (data, response, error) in
            
            if let response = response as? HTTPURLResponse {
                print("Status Code: \(response.statusCode)")
            }
            
            if let error = error {
                print("Failed to retrieve blockchain information \(error)")
                completion(nil,.noDataAvailable)
            } else if let data = data {
                let decoder = JSONDecoder()
                
                do {
                    let infoResponse = try decoder.decode(BlockchainInfoResponse.self, from: data)
                    
                    if let weakSelf = self {
                        weakSelf.test()
                    }
                    
                    
                    self?.getBlock(for: infoResponse.headBlockId, completion: { (response, error) in
                        completion(response,error)
                    })
                    
                } catch {
                    print(error)
                    completion(nil,.noDataAvailable)
                }
            }
            }.resume()
    }
    
    func test() {
        return
    }
    
    
    func getBlock(for id: String, completion: @escaping DidFetchBlockDataCompletion) {
        guard let url = getBlockUrl else {
            return
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        let parameters = "{\"block_num_or_id\": \"\(id)\" }"
        request.httpBody = parameters.data(using: .utf8)
        
        URLSession.shared.dataTask(with: request) { (data, response, error) in
            
            if let response = response as? HTTPURLResponse {
                print("Status Code: \(response.statusCode)")
            }
            
            if let error = error {
                print("Failed to retrieve block \(error)")
                completion(nil,.noDataAvailable)
            } else if let data = data {
                let decoder = JSONDecoder()
                
                do {
                    var blockResponse = try decoder.decode(BlockResponse.self, from: data)
                    blockResponse.data = data
                    completion(blockResponse,nil)
                } catch {
                    print(error)
                    completion(nil,.noDataAvailable)
                }
            }
            }.resume()
    }
}
