//
//  ButtonExpression.swift
//  Cortex
//
//  Created by Bruno Garelli on 9/23/17.
//  Copyright © 2017 Bruno Garelli. All rights reserved.
//

import Foundation
class ButtonExpression: Expression, ResponsiveExpression {
    var type: String = ""
    
    func didResponded() {
        
    }
    
    var name = ""
    var config = DicSAny()
    
}
