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
        
    }
    
}
