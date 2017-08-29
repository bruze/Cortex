//
//  OwnTypes.swift
//  Cortex
//
//  Created by Bruno Garelli on 7/15/17.
//  Copyright © 2017 Bruno Garelli. All rights reserved.
//

import Foundation

typealias DicSAny = [String: Any]
typealias MtxSSany = [String: DicSAny]
//MARK: Fonts
//typealias DicSFont = [String: Font]
//MARK: XML
typealias XMLChk = (XML)->Bool
typealias Result = (success: Bool, report: String, object: AnyObject?)
struct Expression {
    var name = ""
    var type = ""
    var config = DicSAny()
}
