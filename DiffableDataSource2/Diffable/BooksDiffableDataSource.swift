//
//  BooksDiffableDataSource.swift
//  DiffableDataSource2
//
//  Created by SR on 8/1/20.
//  Copyright © 2020 SR. All rights reserved.
//

import Foundation
import UIKit



protocol BooksEmptyDelegate: class {
    
    func showEmptyView(_ isHidden: Bool)
}


class BooksDiffableDataSource: UICollectionViewDiffableDataSource<Section, TextBook> {
    
    
    weak var delegate: BooksEmptyDelegate?
    
    
    override func apply(_ snapshot: NSDiffableDataSourceSnapshot<Section, TextBook>, animatingDifferences: Bool = true, completion: (() -> Void)? = nil) {
        super.apply(snapshot, animatingDifferences: animatingDifferences, completion: completion)
     
        delegate?.showEmptyView(!snapshot.itemIdentifiers.isEmpty)
    }
}



/*  A worth to reading tut found at
 *  https://www.swiftjectivec.com/diffable-datasource-empty-view/
 */
