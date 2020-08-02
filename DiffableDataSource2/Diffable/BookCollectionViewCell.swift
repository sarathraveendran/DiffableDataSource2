//
//  BookCollectionViewCell.swift
//  DiffableDataSource2
//
//  Created by SR on 8/1/20.
//  Copyright © 2020 SR. All rights reserved.
//

import Foundation
import UIKit


protocol BookDelegate: class {
    
    func delete(_ book: TextBook)
    func love(_ book: TextBook)
}


class BookCollectionViewCell: UICollectionViewCell {
    
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var bookImageView: UIImageView!
    @IBOutlet weak var loveButton: UIButton!
       
    
    weak var delegate: BookDelegate?
    
    
    var data: TextBook? {
        
        didSet {
            
            nameLabel.text = data?.name
            bookImageView.image = UIImage(named: data?.image ?? "")
            
            let isUserLoveThisBook = data?.isLovedOne ?? false
            let loveImage = isUserLoveThisBook ? #imageLiteral(resourceName: "heart_filled") : #imageLiteral(resourceName: "heart")
            loveButton.setImage(loveImage, for: .normal)
        }
    }
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }
}




extension BookCollectionViewCell {
    
    @IBAction func deleteAction(_ sender: UIButton) {
        
        delegate?.delete(self.data!)
    }
    
    
    @IBAction func loveAction(_ sender: UIButton) {
        
        data?.isLovedOne = !(data?.isLovedOne ?? false)
        delegate?.love(self.data!)
    }
}




class BookCollectionViewCellType2: BookCollectionViewCell {
    
}
