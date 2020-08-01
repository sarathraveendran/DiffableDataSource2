//
//  DVideo.swift
//  DiffableDataSource2
//
//  Created by SR on 8/1/20.
//  Copyright © 2020 SR. All rights reserved.
//

import Foundation
import UIKit

struct TextBook: Decodable {
    
    let id: String
    let name: String
    let image: String
}



extension TextBook: Hashable {
    
    
    func hash(into hasher: inout Hasher) {
        
        hasher.combine(id)
    }
    
    
    static func == (lhs: TextBook, rhs: TextBook) -> Bool {
        
        lhs.id == rhs.id
    }
}




/*  Step 1
 *  Implemented hash(into:), which hashes the given components.
 *  Added the id of Text Book to the hash.
 *  For Text Books, you only need the ID to know whether two books are equal.
 */

/* Step 2
 * Implemented the Equatable protocol’s == function, because all Hashable objects must also be Equatable.
 */
