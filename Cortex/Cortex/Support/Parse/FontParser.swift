//
//  FontParser.swift
//  Cortex
//
//  Created by Bruno Garelli on 7/15/17.
//  Copyright © 2017 Bruno Garelli. All rights reserved.
//
import Cocoa
import Foundation
class FontParser {
    static fileprivate let privInstance = FontParser()
    static var shared: FontParser {
        get {
            return privInstance
        }
    }
    fileprivate var hold = Holdings()
    fileprivate struct Holdings {
        var fontsLoaded: MtxSSany = [:]
        var amkDir: String = ""
    }
    fileprivate init() {
        //parseFonts(From: [], AddToMem: false, AddToDefDB: false)
    }
    func getLastFontsInMemory() -> MtxSSany {
        return hold.fontsLoaded
    }
    func getAmkDir() -> String {
        return hold.amkDir
    }
    func parseFonts(From xmls: [XML], With names: [String] = [], AddToMem add2Mem: Bool, AddToDB dbURL: URL) -> (Bool, MtxSSany) {
        var dbURL = dbURL
        let dic = NSMutableDictionary()
        var result: MtxSSany = [:]
        var cnt = 1
        xmls.forEach { (xml) in
            //print(xml.attributes)
            var setName = xml.name + String(cnt)
            if !names.isEmpty {
                setName = names[cnt-1]
            }
            dic.addEntries(from: /*[setName:*/ xml.attributes/*]*/)
            result[setName] = xml.attributes
            cnt += 1
            //
            /*var filePath = dbURL.path//getFileURL(fileName: setName + ".plist").path!
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
            }*/
            let seekResult = seekFolder(In: dbURL, Named: "amk")
            //dbURL.appendingPathComponent(<#T##pathComponent: String##String#>, isDirectory: <#T##Bool#>)
            if /*amkFound*/seekResult.success {
                if let filePath = seekResult.object as? String {
                    hold.amkDir = filePath + "/amk/"
                    let setFilePath = hold.amkDir + setName + ".plist"
                    let unsaf = UnsafeMutablePointer<ObjCBool>.allocate(capacity: 1)
                    unsaf[0] = false
                    if !FileManager.default.fileExists(atPath: setFilePath, isDirectory: unsaf) {
                        let _ = dic.write(toFile: setFilePath, atomically: true)
                    }
                }
            }
            
            //
            dic.removeAllObjects()
        }
        //let filePath = getFileURL(fileName: "data.plist").path!
        //let success = dic.write(toFile: filePath, atomically: true)
        if add2Mem {
            hold.fontsLoaded = result
        }
        return (true, result)
    }
    func fontFrom(Description data: DicSAny) -> NSFont {
        var result = NSFont.init()
        if let sysType = data["type"] as? String, sysType == "system" {
            result = NSFont.systemFont(ofSize: 20)
        } else if let fontName = data["name"] as? String {
            result = NSFont(name: fontName, size: /*String(data["pointSize"])*/20)!
        }
        return result
    }
    func getFileURL(fileName: String) -> NSURL {
        let manager = FileManager.default
        let dirURL = try! manager.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: false)
        return dirURL.appendingPathComponent(fileName) as NSURL
    }
    internal func font(From xml: XML) -> NSFont {
        let size = NSString.init(string: xml.attributes["pointSize"]!).floatValue
        let result = NSFont.init(name: xml.attributes["name"]!, size: CGFloat(size))
        return result!
    }
}
