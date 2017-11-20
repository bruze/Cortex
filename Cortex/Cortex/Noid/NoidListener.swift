//
//  Noid.swift
//  Cortex
//
//  Created by Bruno Garelli on 10/14/17.
//  Copyright © 2017 Bruno Garelli. All rights reserved.
//

import Foundation

protocol NoidListener/*: NSObjectProtocol*/ {
    func eventStarted(afterDo: ()->())
    func eventUpdated(afterDo: ()->())
    func eventEnded(afterDo: ()->())
    func eventTransformed(afterDo: ()->())
}
