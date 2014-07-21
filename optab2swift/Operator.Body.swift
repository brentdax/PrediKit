//
//  Operator.Body.swift
//  PrediKit
//
//  Created by Brent Royal-Gordon on 7/11/14.
//  Copyright (c) 2014 Architechies. All rights reserved.
//

import Foundation

extension Operator {
    enum Body {
        case Function (functionName: String)
        case Custom (code: String)
        
        init(typeString: String, contentString: String) {
            switch typeString {
            case "function":
                self = .Function (functionName: contentString)
            case "custom":
                self = .Custom (code: contentString)
            default:
                debugPrintln("Unknown operator body type \(typeString)")
                abort()
            }
        }
        
        func generateCode(#operands: [String], anyObjectOperands: [Int]) -> String {
            switch self {
            case let .Function(functionName: name):
                let operandList = join(", ", map(realEnumerate(operands)) { (i, name) in
                    if contains(anyObjectOperands, i) {
                        return "NSExpression(forConstantValue: \(name))"
                    }
                    else {
                        return name
                    }
                })
                return "NSExpression(forFunction: \"\(name)\", arguments: [\(operandList)])"
            case let .Custom(code: code):
                return code
            }
        }
    }
}