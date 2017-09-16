//
//  Key.swift
//  Cortex
//
//  Created by Bruno Garelli on 9/11/17.
//  Copyright © 2017 Bruno Garelli. All rights reserved.
//

//import Foundation
struct key {
    struct name {
        static let cortex = "cort"
    }
    struct paths {
        struct cortex {
            static let cortexConfig = "config.xml"
            static let cortexConfigFirstSlash = "/config.xml"
            
            static let cortexFolderLastSlash = "cort/"
            static let cortexFolderFirstSlash = "/cort"
            static let cortexFolderBothSlash = "/cort/"
            static let cortexFolderHidden = ".cort"
        }
    }
}
