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
}



extension Video {
    
    static let allVideos = [
        Video(name: "SwiftUI", image: UIImage(named: "swiftui")!),
        Video(name: "Data Structures & Algorithms in Swift", image: UIImage(named: "datastructures")!),
        Video(name: "Beginning ARKit", image: UIImage(named: "arkit")!),
        Video(name: "Fastlane for iOS", image: UIImage(named: "fastlane")!),
        Video(name: "Machine Learning in iOS", image: UIImage(named: "machinelearning")!),
        Video(name: "Beginning RxSwift", image:  UIImage(named: "rxswift")!),
        Video(name: "Demystifying Views in iOS", image: UIImage(named: "views")!),
        Video(name: "Push Notifications", image: UIImage(named: "notifications")!),
        Video(name: "Reproducing Popular iOS Controls", image: UIImage(named: "controls")!)
    ]
}
