//
//  Key.swift
//  Cortex
//
//  Created by Bruno Garelli on 9/11/17.
//  Copyright © 2017 Bruno Garelli. All rights reserved.
//

//import Foundation
struct key {
    struct tag {
        static let tagAll = "TAG_ALL"
    }
    struct name {
        static let cortex = "cort"
    }
    struct font {
        static let systemFont = "System"
    }
    struct parser {
        static let keyFontName = "fontName"
        static let keyFontFamily = "family"
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
