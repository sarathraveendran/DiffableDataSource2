//
//  Section.swift
//  DiffableDataSource2
//
//  Created by SR on 8/1/20.
//  Copyright © 2020 SR. All rights reserved.
//

import Foundation


struct Section: Decodable {
    
    let id: String
    let name: String
    var books: [TextBook]
}



extension Section: Hashable {
    
    
    func hash(into hasher: inout Hasher) {
        
        hasher.combine(id)
    }
    
    
    static func == (lhs: Section, rhs: Section) -> Bool {
        
        lhs.id == rhs.id
    }
}




extension Section {
    
    static var allBooks: [Section] {
        
        return Bundle.loadJSON("Books")!
    }
}
