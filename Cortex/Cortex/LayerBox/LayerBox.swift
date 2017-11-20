//
//  LayerBox.swift
//  Cortex
//
//  Created by Bruno Garelli on 8/26/17.
//  Copyright © 2017 Bruno Garelli. All rights reserved.
//
import Foundation
import Cocoa

class LayerBox: NSBox {
    override func awakeFromNib() {
        super.awakeFromNib()
        self.wantsLayer = true  // NSView will create a CALayer automatically
        let asel = #selector(NSView.init(frame:))
        let ares = perform(asel, with: CGRect.init(x: 0, y: 0, width: 0, height: 0))
        let symbols = Thread.callStackSymbols;
        
        Swift.print()
    }
    
    override var wantsUpdateLayer: Bool
    {
        return true
    }
    
    override func updateLayer() {
        super.updateLayer()
        layer?.sublayers?.removeAll()
        if expressions.count > 0 {
            for expression in expressions {
                if expression.value/*.type == "text"*/ is ButtonExpression {
                    let textLayer = CATextLayer.init()
                     textLayer.frame = CGRect.init(origin: CGPoint.zero, size: CGSize.init(width: 100, height: 100))
                     textLayer.string = "pebete"
                     textLayer.font = FontParser.shared.fontFrom(Description: expression.value.config)
                     textLayer.backgroundColor = CGColor.black
                    layer?.addSublayer(textLayer)
                } else {
                    let newLayer = CALayer.init()
                    //newLayer.contentsRect = CGRect.init(x: 100, y: 100, width: 200, height: 100)
                    /*newLayer.backgroundColor = CGColor.init(red: 1.0, green: 0.65, blue: 0.25, alpha: 1.0)*/
                    newLayer.frame = CGRect.init(x: 100, y: 100, width: 200, height: 100)
                    newLayer.backgroundColor = CGColor.init(red: 1, green: 0, blue: 0, alpha: 1)
                    var newFrame = newLayer.frame
                    newFrame.origin.y += 25
                    newLayer.shadowPath = CGPath.init(ellipseIn: newFrame, transform: nil)
                    newLayer.shadowColor = CGColor.init(red: 0, green: 0, blue: 1, alpha: 1)
                    newLayer.shadowRadius = 10.0
                    newLayer.shadowOffset = CGSize.init(width: 20, height: 20)
                    layer!.addSublayer(newLayer)
                    //layer!.addSublayer(CAGradientLayer.init(layer: newLayer))
                }
                if deleteExpression(By: expression.value.name).success {
                    
                }
            }
        }
    }
    
}
