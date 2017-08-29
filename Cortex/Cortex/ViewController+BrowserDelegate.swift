//
//  ViewController+BrowserDelegate.swift
//  Cortex
//
//  Created by Bruno Garelli on 8/26/17.
//  Copyright © 2017 Bruno Garelli. All rights reserved.
//

import Cocoa
extension ViewController: NSBrowserDelegate {
    func rootItem(for browser: NSBrowser) -> Any? {
        return URL.init(string: FontParser.shared.getAmkDir())
    }
    func browser(_ browser: NSBrowser, numberOfChildrenOfItem item: Any?) -> Int {
        if let url = item as? URL {
            do {
                let urls = try FileManager.default.contentsOfDirectory(
                    at: url,
                    includingPropertiesForKeys: nil,
                    options: FileManager.DirectoryEnumerationOptions.skipsHiddenFiles)
                return urls.count
            }
            catch let error as NSError{
                print (error.localizedDescription)
            }
        }
        return 0
    }
    func browser(_ browser: NSBrowser, child index: Int, ofItem item: Any?) -> Any {
        if let url = item as? URL {
            do {
                let urls = try FileManager.default.contentsOfDirectory(
                    at: url,
                    includingPropertiesForKeys: nil,
                    options: FileManager.DirectoryEnumerationOptions.skipsHiddenFiles)
                return urls[index]
            }
            catch let error as NSError{
                print (error.localizedDescription)
            }
        }
        return URL(fileURLWithPath: "") //fallback
    }
    func browser(_ browser: NSBrowser, isLeafItem item: Any?) -> Bool {
        if let url = item as? URL{
            if url.fileExists() {
                return !url.isDirectory()
            }
        }
        return true
    }
    
    
    func browser(_ browser: NSBrowser, objectValueForItem item: Any?) -> Any? {
        if let u = item as? URL {
            return u.lastPathComponent
        }
        return "ERR"
    }
}
