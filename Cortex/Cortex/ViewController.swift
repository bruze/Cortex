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

    @IBAction func showLoadStoryboardView(_ sender: NSButton) {
        let oPanel = NSOpenPanel.init()
        var dbURL = URL(string: "")
        oPanel.begin { (intResult) in
            if intResult == NSFileHandlingPanelOKButton {
                do {
                    dbURL = oPanel.urls[0]
                    let xmlDoc = try! XMLDocument.init(contentsOf: dbURL!, options: 0)
                    let xml = XML(data: xmlDoc.xmlData)
                    self.rememberThis = try! (xml?["#scenes.scene.objects.viewController.view"].getXML())!
                    let someThingToPrint = XML.lookChildrenInto(Xml: self.rememberThis, ForTag: "fontDescription", FetchAttrFrom: "color", If: {
                        xml in
                        return xml.parent!.name == "label"
                    })
                    let fPar = FontParser.shared
                    let _ = fPar.parseFonts(From: someThingToPrint, AddToMem: false, AddToDB: oPanel.urls[0])
                    //print(someThingToPrint.count)
                } catch {
                    print("Failure")
                }
            }
        }
        
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
        }
    }
    public func numberOfRows(in tableView: NSTableView) -> Int {
        return data.count
    }
    public func tableView(_ tableView: NSTableView, objectValueFor tableColumn: NSTableColumn?, row: Int) -> Any? {
        return data[row]
    }
}
