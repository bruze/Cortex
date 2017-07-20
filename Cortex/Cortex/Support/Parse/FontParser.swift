//
//  FontParser.swift
//  Cortex
//
//  Created by Bruno Garelli on 7/15/17.
//  Copyright © 2017 Bruno Garelli. All rights reserved.
//

import Foundation
class FontParser {
    static fileprivate let privInstance = FontParser()
    static var shared: FontParser {
        get {
            return privInstance
        }
    }
    fileprivate let hold = Holdings()
    fileprivate struct Holdings {
        var fontsLoaded: MtxSSany = [:]
    }
    fileprivate init() {
        //parseFonts(From: [], AddToMem: false, AddToDefDB: false)
    }
    func parseFonts(From xmls: [XML], AddToMem add2Mem: Bool, AddToDB dbURL: URL) -> (Bool, [MtxSSany]) {
        var dbURL = dbURL
        let dic = NSMutableDictionary()
        var result: [MtxSSany] = []
        var cnt = 1
        xmls.forEach { (xml) in
            //print(xml.attributes)
            let setName = xml.name + String(cnt)
            var matrix: MtxSSany = [:]
            dic.addEntries(from: /*[setName:*/ xml.attributes/*]*/)
            matrix[setName] = xml.attributes
            result.append(matrix)
            cnt += 1
            //
            print("")
            var filePath = dbURL.path//getFileURL(fileName: setName + ".plist").path!
            let unsaf = UnsafeMutablePointer<ObjCBool>.allocate(capacity: 1)
            unsaf[0] = true
            var amkFound = true
            while !FileManager.default.fileExists(atPath: dbURL.path + "/amk", isDirectory: unsaf) {
                dbURL = dbURL.deletingLastPathComponent()
                filePath = dbURL.path
                if dbURL.lastPathComponent.characters.count == 1  {
                    amkFound = false
                    break
                }
            }
            //dbURL.appendingPathComponent(<#T##pathComponent: String##String#>, isDirectory: <#T##Bool#>)
            if amkFound {
                let success = dic.write(toFile: filePath, atomically: true)
            }
            
            //
            dic.removeAllObjects()
        }
        //let filePath = getFileURL(fileName: "data.plist").path!
        //let success = dic.write(toFile: filePath, atomically: true)
        return (true, result)
    }
    func getFileURL(fileName: String) -> NSURL {
        let manager = FileManager.default
        let dirURL = try! manager.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: false)
        return dirURL.appendingPathComponent(fileName) as NSURL
    }
    
    
}
