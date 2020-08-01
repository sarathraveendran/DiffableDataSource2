//
//  BookCollectionViewCell.swift
//  DiffableDataSource2
//
//  Created by SR on 8/1/20.
//  Copyright © 2020 SR. All rights reserved.
//

import Foundation
import UIKit


class BookCollectionViewCell: UICollectionViewCell {
    
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var imageView: UIImageView!
    
    
    var data: TextBook? {
        
        didSet {
            
            nameLabel.text = data?.name
            imageView.image = UIImage(named: data?.image ?? "")
        }
    }
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }
}
