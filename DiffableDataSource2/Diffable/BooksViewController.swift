//
//  DiffableVideosViewController.swift
//  DiffableDataSource2
//
//  Created by SR on 8/1/20.
//  Copyright © 2020 SR. All rights reserved.
//

import Foundation
import UIKit




class BooksViewController: UICollectionViewController {
    
    
    // MARK: Custm Types
    typealias DiffableDataSource = UICollectionViewDiffableDataSource<Section, TextBook>
    
    
    
    // MARK: Props
    lazy var searchController: UISearchController = {
        let controller = UISearchController(searchResultsController: nil)
        controller.searchResultsUpdater = self
        controller.obscuresBackgroundDuringPresentation = false
        controller.searchBar.placeholder = "Search by name"
        return controller
    }()
    var books = Section.allBooks
    lazy var dataSource = createDataSource()
        
    
    
    // MARK: Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setScopeBar()
        setSearchBar()
        setData(false)
    }
    
    
    
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        super.viewWillTransition(to: size, with: coordinator)
        
        self.collectionView.collectionViewLayout.invalidateLayout()
    }
}





extension BooksViewController {
    
    
    func createDataSource() -> DiffableDataSource {
        
        let dataSource = DiffableDataSource(collectionView: self.collectionView) { (collectionView, indexPath, book) -> UICollectionViewCell? in
            
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "BookCollectionViewCell", for: indexPath) as! BookCollectionViewCell
            cell.data = book
            return cell
        }
        return dataSource
    }
    
    
    
    func setData(_ animate: Bool) {
        
        var snapShot = NSDiffableDataSourceSnapshot<Section, TextBook>()
        
        // Set Section
        snapShot.appendSections(books)
        
        // Set Data For Section
        books.forEach { section in
            
            snapShot.appendItems(section.books, toSection: section)
        }
        
        // Push
        dataSource.apply(snapShot, animatingDifferences: animate, completion: nil)
    }
}






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
        setData(true)
    }
}
