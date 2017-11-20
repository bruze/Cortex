//
//  ResponsiveExpression.swift
//  Cortex
//
//  Created by Bruno Garelli on 9/23/17.
//  Copyright © 2017 Bruno Garelli. All rights reserved.
//

import Foundation
/*@objc*/ protocol ResponsiveExpression: Expression {
    //let delegate:  = <#value#>
    func didResponded() 
    //optional func responseArea() -> CGRect
    
}
