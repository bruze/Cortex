//
//  UIViewNoid.swift
//  Cortex
//
//  Created by Bruno Garelli on 10/14/17.
//  Copyright © 2017 Bruno Garelli. All rights reserved.
//
import Result
import ReactiveSwift
import ReactiveCocoa
import Foundation

class Noid: NSObject, NoidListener {
    var trigger: Signal<(), NoError>!
    init(selector: Selector, objReactive: NSObject) {
        super.init()
        trigger = objReactive.reactive.trigger(for: selector)
    }
    func eventStarted(afterDo: ()->()) {
        trigger.observeValues {
            print()
            //afterDo()
        }
    }
    func eventUpdated(afterDo: ()->()) {
        afterDo()
    }
    func eventEnded(afterDo: ()->()) {
        afterDo()
    }
    func eventTransformed(afterDo: ()->()) {
        afterDo()
    }
}
