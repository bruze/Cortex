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
        var fontsNames: [String] = []
        let someThingToPrint = XML.lookChildrenInto(Xml: self.rememberThis, ForTag: "fontDescription", FetchAttrFrom: "color", If: {
            xml in
            let check = xml.parent!.name == "label"
            let configLabel = XML.lookChildrenInto(Xml: xml.parent!, ForTag: "userDefinedRuntimeAttributes", FetchAttrFrom: "StoreID", If: {_ in return true})
            if check && configLabel.count > 0 {
                if let storeID = configLabel.first?.children.first?.attributes["value"] {
                    fontsNames.append(storeID)
                   return true
                }
            }
            return false//check
        })
        let fPar = FontParser.shared
        let parsedFonts = fPar.parseFonts(From: someThingToPrint, With: fontsNames, AddToMem: true, AddToDB: storeURL!)
        let flatted: [String] = parsedFonts.1.reduce([]) { (array, matrix) in
            var result = array
            result.append(matrix.key)
            return result
        }
        data = flatted
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
                    self.rememberThis = try! (xml?["#scenes.scene.objects.viewController.view"].getXML())!
                    
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
