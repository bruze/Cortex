//
//  LayerBox.swift
//  Cortex
//
//  Created by Bruno Garelli on 8/26/17.
//  Copyright © 2017 Bruno Garelli. All rights reserved.
//

import Cocoa

class LayerBox: NSBox {
    override func awakeFromNib() {
        super.awakeFromNib()
        self.wantsLayer = true;  // NSView will create a CALayer automatically
    }
    
    override var wantsUpdateLayer: Bool
    {
        return true
    }
    
    override func updateLayer() {
        super.updateLayer()
        //layer?.sublayers?.removeAll()
        if expressions.count > 0 {
            for expression in expressions {
                if expression.value.type == "text" {
                    let textLayer = CATextLayer.init()
                     textLayer.frame = CGRect.init(origin: CGPoint.zero, size: CGSize.init(width: 100, height: 100))
                     textLayer.string = "pebete"
                     textLayer.font = FontParser.shared.fontFrom(Description: expression.value.config)
                     textLayer.backgroundColor = CGColor.black
                    layer?.addSublayer(textLayer)
                }
                if deleteExpression(By: expression.value.name).success {
                    
                }
            }
        }
    }
    
}
