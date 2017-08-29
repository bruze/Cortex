//
//  URL+Utils.swift
//  Cortex
//
//  Created by Bruno Garelli on 8/26/17.
//  Copyright © 2017 Bruno Garelli. All rights reserved.
//

import Cocoa
extension URL {
    
    func isDirectory() -> Bool {
        return (try? resourceValues(
            forKeys: [.isDirectoryKey]
            ))?.isDirectory ?? false
    }
    
    func fileExists() -> Bool {
        let fileman = FileManager.default
        return fileman.fileExists(atPath: self.path)
    }
    
    var fileIcon : NSImage {
        return (try? resourceValues(
            forKeys: [.effectiveIconKey]
            ))?.effectiveIcon as? NSImage ?? NSImage()
    }
}
