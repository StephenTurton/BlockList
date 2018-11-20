//
//  BlockItemTableViewCell.swift
//  BlockList
//
//  Created by Stephen Turton on 11/20/18.
//  Copyright © 2018 Stephen Turton. All rights reserved.
//

import UIKit

class BlockItemTableViewCell: UITableViewCell {

    static var reuseIdentifier: String {
        return String(describing: self)
    }
    
    @IBOutlet weak var blockNameLabel: UILabel!
    
}
