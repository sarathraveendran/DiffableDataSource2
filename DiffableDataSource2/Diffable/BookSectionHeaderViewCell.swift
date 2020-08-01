//
//  BookSectionHeaderViewCell.swift
//  DiffableDataSource2
//
//  Created by SR on 8/1/20.
//  Copyright © 2020 SR. All rights reserved.
//

import Foundation
import UIKit



class BookSectionHeaderViewCell: UICollectionReusableView {
    
    @IBOutlet weak var nameLabel: UILabel!
    
    
    var data: String? {
        
        didSet {
            
            nameLabel.text = data
        }
    }
}
