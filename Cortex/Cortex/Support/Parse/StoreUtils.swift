//
//  StoreUtils.swift
//  Cortex
//
//  Created by Bruno Garelli on 8/26/17.
//  Copyright © 2017 Bruno Garelli. All rights reserved.
//
import Cocoa
import Foundation
func seekFolder(In startPath: URL, Named folderName: String) -> Result {
    var result = Result(false, "", nil)
    var startPath = startPath
    var filePath = startPath.path
    let unsaf = UnsafeMutablePointer<ObjCBool>.allocate(capacity: 1)
    unsaf[0] = true
    //var amkFound = true
    while !FileManager.default.fileExists(atPath: startPath.path + "/" + folderName, isDirectory: unsaf) {
        startPath = startPath.deletingLastPathComponent()
        filePath = startPath.path
        if startPath.lastPathComponent.characters.count == 1  {
            //amkFound = false
            result.report = "Directory not found(!)"
            break
        }
    }
    result.object = filePath as AnyObject
    result.success = true
    return result
}
