//
//  BooksDeleteAndLove.swift
//  DiffableDataSource2
//
//  Created by SR on 8/1/20.
//  Copyright © 2020 SR. All rights reserved.
//

import Foundation
import UIKit


extension BooksViewController: BookDelegate {
    
    
    func delete(_ book: TextBook) {
        
        var snapshot = dataSource.snapshot()
        snapshot.deleteItems([book])
        dataSource.apply(snapshot, animatingDifferences: true, completion: nil)
    }
    
    
    /*  ------------- Not Ideal Solution ------------
     *  Current approach is not an optmized one for single item update
     *  If any one find better approach please let me know
     */
    func love(_ book: TextBook) {
        
        let updatedBooks = self.books.map { section -> Section in
            var _section = section
            let _books = _section.books.map({ $0.id == book.id ? book : $0 })
            _section.books = _books
            return _section
        }
        self.books = updatedBooks
        setData(true)
    }
}


/*
 *   We can also easily define partial updates to our UI, by grabbing a copy of our data source’s current snapshot
 *    (by calling the snapshot() method on it), modifying it, and then passing it back through apply()
 *  — like in this example, where we build a method that lets us remove a contact from our list:
 */
