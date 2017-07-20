//
//  CommonExtensions.swift
//  Cortex
//
//  Created by Bruno Garelli on 6/8/17.
//  Copyright © 2017 Bruno Garelli. All rights reserved.
//

import Foundation
extension Array {
    public func random() -> Element? {
        guard count > 0 else { return nil }
        let index = Int(arc4random_uniform(UInt32(self.count)))
        return self[index]
    }
}
