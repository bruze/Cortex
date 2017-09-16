//
//  ViewController.swift
//  Cortex
//
//  Created by Bruno Garelli on 6/5/17.
//  Copyright © 2017 Bruno Garelli. All rights reserved.
//

import Cocoa

class ViewController: NSViewController {
    @IBOutlet weak var table: NSTableView!
    @IBOutlet weak var previewBox: LayerBox!
    @IBOutlet weak var browser: NSBrowser!
    
    var storeURL = URL(string: "")
    var subViews: [XML] = []
    var rememberThis: XML = XML.init(name: "")
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        //reload()
    }

    override var representedObject: Any? {
        didSet {
        // Update the view, if already loaded.
        }
    }

    @IBAction func processData(_ sender: NSButton) {
        if (storeURL?.lastPathComponent.contains(".xcode"))! {
            let cortex = key.name.cortex
            let seekResult = seekFolder(In: storeURL!, Named: cortex)
            if /*amkFound*/seekResult.success {
                if let filePath = seekResult.object as? String {
                    print()
                    let setFilePath = filePath + key.paths.cortex.cortexFolderBothSlash
                    let unsaf = UnsafeMutablePointer<ObjCBool>.allocate(capacity: 1)
                    unsaf[0] = false
                    if !FileManager.default.fileExists(atPath: setFilePath, isDirectory: unsaf) {
                        //dic.addEntries(from: ["spaces" : ["void": ["": ""]]])
                        //let _ = dic.write(toFile: setFilePath, atomically: true)
                        print()
                    }
                } else {
                    print()
                }
            } else {
                print()
                let setPath = storeURL?.deletingLastPathComponent().appendingPathComponent(key.paths.cortex.cortexFolderHidden, isDirectory: true)
                do {
                    try FileManager.default.createDirectory(at: setPath!, withIntermediateDirectories: true, attributes: nil)
                    
                    let dic = NSMutableDictionary()
                    let setFilePath = (setPath?.relativePath)! + key.paths.cortex.cortexConfigFirstSlash
                    
                    /*let xml = XML.init(string: setFilePath)
                    dic.addEntries(from: xml.attributes)
                    for sub in xml.children {
                        dic.addEntries(from: sub.attributes)
                    }*/
                    dic.addEntries(from: ["spaces" : ["void":["props": ""]]])
                    let _ = dic.write(toFile: setFilePath, atomically: true)
                    
                    /*FileManager.default.createFile(atPath: (setPath?.relativePath)! + key.paths.cortex.cortexConfigFirstSlash, contents: nil, attributes: nil)*/
                    let alert = NSAlert.init()
                    alert.messageText = "Cortex started: No previous cortex config found"
                } catch {
                    print(error)
                    let alert = NSAlert.init(error: error)
                    alert.beginSheetModal(for: view.window!, completionHandler: { (response) in
                        
                    })
                }
                
            }
        }
        //return
        var fontsNames: [String] = []
        let someThingToPrint = XML.lookChildrenInto(Xml: self.rememberThis, ForTags: /*"fontDescription"*/["fontName", "name"], FetchAttrFrom: "color", If: {
            xml in
            /*let check = xml.parent!.name == "label"
            let configLabel = XML.lookChildrenInto(Xml: xml.parent!, ForTag: "userDefinedRuntimeAttributes", FetchAttrFrom: "StoreID", If: {_ in return true})
            if check && configLabel.count > 0 {
                if let storeID = configLabel.first?.children.first?.attributes["value"] {
                    fontsNames.append(storeID)
                   return true
                }
            }
            return false//check*/
            return true
        }, By: "")
        let fPar = FontParser.shared
        let parsedFonts = fPar.parseFonts(From: someThingToPrint, With: fontsNames, AddToMem: true, AddToDB: storeURL!)
        let imhere = true
        let flatted: [String] = parsedFonts.1.reduce([]) { (array, matrix) in
            var result = array
            result.append(matrix.key)
            return result
        }
        data = flatted
        print()
        /*data = someThingToPrint.flatMap({ (xml) -> [String] in
            
        })*/
    }
    @IBAction func showLoadStoryboardView(_ sender: NSButton) {
        let oPanel = NSOpenPanel.init()
        //var dbURL = URL(string: "")
        oPanel.begin { (intResult) in
            if intResult == NSFileHandlingPanelOKButton {
                do {
                    self.storeURL = oPanel.urls[0]
                    let xmlDoc = try! XMLDocument.init(contentsOf: oPanel.urls[0], options: 0)
                    let xml = XML(data: xmlDoc.xmlData)
                    self.rememberThis = xml!
                    
                } catch {
                    print("Failure")
                }
            }
        }
        sender.isHidden = true
    }

}
//MARK: TABLE
extension ViewController: NSTableViewDataSource, NSTableViewDelegate {
    internal func reload() {
        //data = [["data1", "data2"], ["pika1", "pika2"]].random()!
        table.reloadData()
    }
    var data: [String] {
        get {
            return getAssociatedValue(key: "data", object: self, initialValue: [])
        }
        set {
            set(associatedValue: newValue, key: "data", object: self)
            reload()
        }
    }
    public func numberOfRows(in tableView: NSTableView) -> Int {
        return data.count
    }
    public func tableView(_ tableView: NSTableView, objectValueFor tableColumn: NSTableColumn?, row: Int) -> Any? {
        return data[row]
    }
    public func tableViewSelectionDidChange(_ notification: Notification) {
        //previewBox.addSubview(NSTextField.init(string: "cambio"))
        /*let textLayer = CATextLayer.init()
        textLayer.frame = CGRect.init(origin: previewBox.center, size: CGSize.init(width: 100, height: 100))
        textLayer.string = "pebete"
        textLayer.font = NSFont.init(name: "Helvetica", size: 10.0)
        textLayer.backgroundColor = CGColor.black*/
        //previewBox.layer?.addSublayer(textLayer)
        //previewBox.layerContentsRedrawPolicy = NSViewLayerContentsRedrawPolicy.onSetNeedsDisplay
        //print(previewBox.wantsUpdateLayer)
        if let notifyingTable = notification.object as? NSTableView {
            let fonts = FontParser.shared.getLastFontsInMemory()
            if let selection = fonts[data[notifyingTable.selectedRow]] {
                print(selection)
                let expression = Expression(name: "labelTest", type: "text", config: selection)
                if previewBox.add(Expression: expression).success {
                    browser.loadColumnZero()
                }
            }
        }
        
        previewBox.layer?.setNeedsDisplay()
        //previewBox.layer?.displayIfNeeded()
        //previewBox.updateLayer()
        //let newView = NSView.init(frame: NSRect.init(x: 0, y: 0, width: 100, height: 100))
        //newView.layer?.backgroundColor = CGColor.init(red: 200, green: 0, blue: 0, alpha: 1)
        //previewBox.addSubview(newView)
        //previewBox.setNeedsDisplay(newView.frame)
        //print(notification)
    }
}
