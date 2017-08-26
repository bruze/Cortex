//
//  NSView+Utils.swift
//  Cortex
//
//  Created by Bruno Garelli on 8/26/17.
//  Copyright © 2017 Bruno Garelli. All rights reserved.
//

import Cocoa
extension NSView {
    var center: CGPoint {
        var point = CGPoint.init()
        point.x = self.frame.width / 2
        point.y = self.frame.height / 2
        return point
    }
    
}
