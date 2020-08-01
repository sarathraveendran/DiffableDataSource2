//
//  ViewController.swift
//  DiffableDataSource2
//
//  Created by SR on 7/30/20.
//  Copyright © 2020 SR. All rights reserved.
//

import UIKit

class VideosViewController: UICollectionViewController {
    
    
    var dataSource = Video.allVideos
    lazy var searchController: UISearchController = {
        let controller = UISearchController(searchResultsController: nil)
        controller.searchResultsUpdater = self
        controller.obscuresBackgroundDuringPresentation = false
        controller.searchBar.placeholder = "Search by name"
        return controller
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        refresh()
        setScope()
        setSearch()
    }
    
    
    
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        super.viewWillTransition(to: size, with: coordinator)
        
        self.collectionView.collectionViewLayout.invalidateLayout()
    }
    
    
    
    func refresh() {
        
        collectionView.reloadData()
    }
}




extension VideosViewController: UICollectionViewDelegateFlowLayout {
    
    
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return dataSource.count
    }
    
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let width = UIScreen.main.bounds.width 
        let height = (width * 3) / 4
        let size = CGSize(width: width, height: ceil(height))
        return size
    }
    
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
     
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "VideoCollectionViewCell", for: indexPath) as! VideoCollectionViewCell
        cell.data = dataSource[indexPath.item]
        return cell
    }
}





extension VideosViewController: UISearchResultsUpdating {
   
    
    func setSearch() {
        
        navigationItem.searchController = self.searchController
        definesPresentationContext = true
    }
    
    
    
    func updateSearchResults(for searchController: UISearchController) {
        
        let searchText = searchController.searchBar.text
        
        let searchBar = searchController.searchBar
        let selectedCategoryName = searchBar.scopeButtonTitles![searchBar.selectedScopeButtonIndex]
        let category = VideoCateory(rawValue: selectedCategoryName)
        
        search(searchText!, category: category)
    }
    
}




extension VideosViewController: UISearchBarDelegate {
    
    
    func setScope() {
    
        self.searchController.searchBar.scopeButtonTitles = VideoCateory.allCases.map({ $0.name })
        self.searchController.searchBar.delegate = self
    }
    
    
    func searchBar(_ searchBar: UISearchBar, selectedScopeButtonIndexDidChange selectedScope: Int) {
        
        let selectedTitle = searchBar.scopeButtonTitles![selectedScope]
        let category = VideoCateory(rawValue: selectedTitle)
        search(searchBar.text!, category: category)
    }
}




extension VideosViewController {
    
    
    func search(_ text: String, category: VideoCateory?) {
        
        let searchText = text.lowercased()
        dataSource = Video.allVideos.filter({ video -> Bool in
            
            let isCategoryMatching = category == .All || video.category == category
            if searchText.isEmpty {
               
                return isCategoryMatching
            } else {
                
                let isSearchMatching = video.name.lowercased().contains(searchText)
                return isCategoryMatching && isSearchMatching
            }
        })
        refresh()
    }
}
