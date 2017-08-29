//
//  LayerBox+Expression.swift
//  Cortex
//
//  Created by Bruno Garelli on 8/26/17.
//  Copyright © 2017 Bruno Garelli. All rights reserved.
//

extension LayerBox {
    var expressions: [String: Expression] {
        get {
            return getAssociatedValue(key: Expressions, object: self, initialValue: [:])
        }
        set {
            set(associatedValue: newValue, key: Expressions, object: self)
        }
    }
    func add(Expression anExp: Expression) -> Result {
        var result = Result(false, "", nil)
        if !anExp.name.isEmpty {
            expressions[anExp.name] = anExp
            result.success = true
        } else {
            result.report = "Empty Expression Name(!)"
        }
        if !result.report.isEmpty {
            Swift.print(result.report)
        }
        return result
    }
    func deleteExpression(By anId: String) -> Result {
        var result = Result(false, "", nil)
        if let _ = expressions[anId] {
            expressions.removeValue(forKey: anId)
            result.success = true
        } else {
            result.report = "Couldn't find Expression(!)"
        }
        if !result.report.isEmpty {
            Swift.print(result.report)
        }
        return result
    }
}
