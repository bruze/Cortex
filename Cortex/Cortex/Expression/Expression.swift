//
//  Expression.swift
//  Cortex
//
//  Created by Bruno Garelli on 9/23/17.
//  Copyright © 2017 Bruno Garelli. All rights reserved.
//

import Foundation
protocol Expression {
    var name: String { get }
    var type: String { get set }
    var config: DicSAny { get set }
}

