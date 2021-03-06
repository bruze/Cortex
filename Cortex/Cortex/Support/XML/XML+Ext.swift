//
//  XML+Ext.swift
//  Cortex
//
//  Created by Bruno Garelli on 6/6/17.
//  Copyright © 2017 Bruno Garelli. All rights reserved.
//

import Foundation
extension XML {
    internal func deepSearch(inXml xml: XML, trigger: String, accessTag: String) -> [XML] {
        var result: [XML] = []
        guard !trigger.isEmpty else{ return result}
        if let triggerObj = xml["#"+trigger].xml {
            //result.append(triggerObj)
            let triggerCollection = triggerObj.children
            for child in triggerCollection {
                result.append(contentsOf: deepSearch(inXml: child, trigger: trigger, accessTag: accessTag).filter({
                xml in xml.name == "fontDescription"}))
            }
        } else {
            //let introspection = lookChildrenInto(Xml: xml, ForTag: "fontDescription")
            //print(introspection)
        }
        return result
    }
    internal static func lookChildrenInto(Xml anXml: XML, ForTag aTag: String) -> [XML] {
        var result: [XML] = []
        for child in anXml.children {
            if child.name == aTag {
                result.append(child)
            } else {
                result.append(contentsOf: lookChildrenInto(Xml: child, ForTag: aTag))
            }
        }
        return result
    }
    internal static func lookChildrenInto(Xml anXml: XML, ForTag aTag: String, If meetCond: XMLChk) -> [XML] {
        var result: [XML] = []
        for child in anXml.children {
            if child.name == aTag {
                guard meetCond(child) else { continue }
                result.append(child)
            } else {
                result.append(contentsOf: lookChildrenInto(Xml: child, ForTag: aTag, If: meetCond))
            }
        }
        return result
    }
    internal static func lookChildrenInto(Xml anXml: XML, ForTags tags: [String], FetchAttrFrom siblingTag: String, If meetCond: XMLChk, By keyOrValue: String) -> [XML] {
        var result: [XML] = []
        var counter = 0
        for child in anXml.children {
            var checkValue = ""
            if keyOrValue == "key" {
                checkValue = child.name
            } else {
                checkValue = (child.value != nil) ? child.value! : ""
            }
            if /*checkValue == aTag*/tags.contains(checkValue) {
                guard meetCond(child) else { continue }
                
                result.append(anXml.children[counter])
                //result.append(child)
                if let sibling = anXml.children.filter({ (xml) -> Bool in
                    xml.name == siblingTag
                }).first {
                    //set(associatedValue: sibling, key: SiblingData, object: child)
                    child.addAttributes(sibling.attributes)
                }
            } else {
                result.append(contentsOf: lookChildrenInto(Xml: child, ForTags: tags, FetchAttrFrom: siblingTag, If: meetCond, By: keyOrValue))
            }
            counter += 1
        }
        return result
    }
    static func childrenToDict(root: XML) -> DicSAny {
        var result: DicSAny = [:]
        for child in root.children {
            if let value = child.value {
                result[child.name] = value
            }
        }
        return result
    }
}
