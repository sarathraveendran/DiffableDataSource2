//
//  VideoCollectionViewCell.swift
//  DiffableDataSource2
//
//  Created by SR on 7/30/20.
//  Copyright © 2020 SR. All rights reserved.
//

import Foundation
import UIKit


class VideoCollectionViewCell: UICollectionViewCell {
  
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    
    
    
    var data: Video? {
       
        didSet {
            
            imageView.image = data?.image
            nameLabel.text = data?.name
        }
    }
}
