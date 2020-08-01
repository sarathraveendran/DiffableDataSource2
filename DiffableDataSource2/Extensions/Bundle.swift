//
//  Bundle.swift
//  DiffableDataSource2
//
//  Created by SR on 8/1/20.
//  Copyright © 2020 SR. All rights reserved.
//

import Foundation


extension Bundle {
    
     static func loadJSON<T: Decodable>(_ fileName: String) -> T? {
        
        guard let filePath = main.url(forResource: fileName, withExtension: ".json") else { return nil }
        guard let content = try? Data(contentsOf: filePath) else { return nil }
        guard let modal = try? JSONDecoder().decode(T.self, from: content) else { return nil }
        return modal
    }
}
