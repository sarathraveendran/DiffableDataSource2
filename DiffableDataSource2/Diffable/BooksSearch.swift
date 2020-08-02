//
//  BooksSearch.swift
//  DiffableDataSource2
//
//  Created by SR on 8/1/20.
//  Copyright © 2020 SR. All rights reserved.
//

import Foundation
import UIKit



extension BooksViewController: UISearchResultsUpdating {
   
    
    func setSearchBar() {
        
        navigationItem.searchController = self.searchController
        definesPresentationContext = true
    }
    
    
    
    func updateSearchResults(for searchController: UISearchController) {
        
        let searchText = searchController.searchBar.text
        
        let searchBar = searchController.searchBar
        let categoryName = searchBar.scopeButtonTitles![searchBar.selectedScopeButtonIndex]
        
        search(searchText!, categoryName: categoryName)
    }
    
}




extension BooksViewController: UISearchBarDelegate {
    
    
    func setScopeBar() {
    
        self.searchController.searchBar.scopeButtonTitles = Section.allBooks.map({ $0.name })
        self.searchController.searchBar.delegate = self
    }
    
    
    func searchBar(_ searchBar: UISearchBar, selectedScopeButtonIndexDidChange selectedScope: Int) {
        
        let categoryName = searchBar.scopeButtonTitles![selectedScope]
        search(searchBar.text!, categoryName: categoryName)
    }
}




extension BooksViewController {
    
    
    func search(_ text: String, categoryName: String?) {
        
        let searchText = text.lowercased()
        books = Section.allBooks.compactMap({ section -> Section? in

            var _section = section
            let isCategoryMatching = _section.name == categoryName
            if !searchText.isEmpty {

                let books = _section.books.filter { book -> Bool in
                    
                    let isSearchMatching = book.name.lowercased().contains(searchText)
                    return isCategoryMatching && isSearchMatching
                }
                if books.count > 0 {
                    
                    _section.books = books
                    return _section
                }
            } else if isCategoryMatching {
                 
                return _section
            }

            return nil
        })
        setData(animate: true)
    }
}

/*
 *   When doing the above, our UICollectionViewDiffableDataSource will take the snapshot we constructed, diff it
 *   — and then update our UI with the resulting changes
 *  — all automatically, including calculating the most appropriate animations to use.
 */
