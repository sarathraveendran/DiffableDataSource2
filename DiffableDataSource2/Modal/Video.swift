//
//  Video.swift
//  DiffableDataSource2
//
//  Created by SR on 7/30/20.
//  Copyright © 2020 SR. All rights reserved.
//

import Foundation
import UIKit

struct Video {
    
    let id = UUID()
    let name: String
    let image: UIImage
    let category: VideoCateory
}


enum VideoCateory: String, CaseIterable {
    
    case All
    case DS
    case SwiftUI
    case UIKit
    case Others
    
    var name: String {
        return self.rawValue
    }
}


extension Video {
    
    static let allVideos = [
        Video(name: "SwiftUI", image: UIImage(named: "swiftui")!, category: .SwiftUI),
        Video(name: "Data Structures & Algorithms in Swift", image: UIImage(named: "datastructures")!, category: .DS),
        Video(name: "Beginning ARKit", image: UIImage(named: "arkit")!, category: .UIKit),
        Video(name: "Fastlane for iOS", image: UIImage(named: "fastlane")!, category: .Others),
        Video(name: "Machine Learning in iOS", image: UIImage(named: "machinelearning")!, category: .UIKit),
        Video(name: "Beginning RxSwift", image:  UIImage(named: "rxswift")!, category: .Others),
        Video(name: "Demystifying Views in iOS", image: UIImage(named: "views")!, category: .UIKit),
        Video(name: "Push Notifications", image: UIImage(named: "notifications")!, category: .UIKit),
        Video(name: "Reproducing Popular iOS Controls", image: UIImage(named: "controls")!, category: .UIKit)
    ]
}
