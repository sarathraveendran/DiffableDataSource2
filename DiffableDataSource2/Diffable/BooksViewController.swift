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
    
    
    // MARK: Connection Objects
    @IBOutlet weak var emptyImageView: UIImageView!
    
    
    
    // MARK: Custm Types
    typealias DiffableDataSource = BooksDiffableDataSource
    
    
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
        setData(animate: false)
    }
    
    
    
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        super.viewWillTransition(to: size, with: coordinator)
        
        self.collectionView.collectionViewLayout.invalidateLayout()
    }
}





extension BooksViewController {
    
    
    func createDataSource() -> DiffableDataSource {
        
        // CELL
        let dataSource = DiffableDataSource(collectionView: self.collectionView) { (collectionView, indexPath, book) -> UICollectionViewCell? in
            
            if indexPath.section == 2 {
                
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "BookCollectionViewCellType2", for: indexPath) as! BookCollectionViewCellType2
                cell.data = book
                cell.delegate = self
                return cell
            } else {
                
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "BookCollectionViewCell", for: indexPath) as! BookCollectionViewCell
                cell.data = book
                cell.delegate = self
                return cell
            }
        }
        dataSource.delegate = self
        
        // HEADER
        dataSource.supplementaryViewProvider = { collectionView, kind, indexPath in
            
            guard kind == UICollectionView.elementKindSectionHeader else { return nil }
            let view = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "BookSectionHeaderViewCell", for: indexPath) as! BookSectionHeaderViewCell
            let section = dataSource.snapshot().sectionIdentifiers[indexPath.section]
            view.data = section.name
            return view
        }
        
        return dataSource
    }
    
    
    
    func setData(animate: Bool) {
        
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




extension BooksViewController: BooksEmptyDelegate {
    
    func showEmptyView(_ isHidden: Bool) {
        
        self.emptyImageView.isHidden = isHidden
    }
}



extension BooksViewController {
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        guard let selectedItem = dataSource.itemIdentifier(for: indexPath) else { return }
        // Here you go with your selection
    }
}




/* This is conventional approach. We have all new compositional layout now.
 * Following this approach to reduce complexity and easy undertanding.
 */
extension BooksViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        if indexPath.section == 2 {
            
             let width = UIScreen.main.bounds.width
            let size = CGSize(width: width, height: 100)
            return size
        } else {
           

            let width = UIScreen.main.bounds.width
            let height = (width * 3) / 4
            let size = CGSize(width: width, height: ceil(height))
            return size
        }
    }
}
