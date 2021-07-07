//
//  LogicCalcul.swift
//  CountOnMe
//
//  Created by HONORE Adeline on 06/05/2021.
//  Copyright © 2021 Vincent Saluzzo. All rights reserved.
//

import Foundation

class LogicCalcul {
    
    // MARK: - enum
    
    
    
    // MARK: - PROPRETIES
    
    private var operand: Operator = .addition
    private var priorityOperand = ""
    
    
    // MARK: - METHODS
    
    func compute(string: [String]) -> Result<Double, ErrorType> {
        
        var result: [String] = string
        
        guard !LogicCalcul.isOperator(string: string.last) else {
            return .failure(ErrorType.noCorrect)
        }
 
        guard !isMultiOperatorsEquation(equation: string) else {
            return .failure(ErrorType.multiOperator)
        }
        
        result = priorityCalcul(equation: result)
        
        guard !result[0].contains("errorDivision0") else {
            return .failure(ErrorType.division0)
        }
        
        while result.count > 1 {
            result = simpleCalcul(equation: result)
        }
        
        return .success(Double(result[0]) ?? 0.0)
    }
    
    
    private func simpleCalcul(equation: [String]) -> [String] {
        
        var string = equation
        
        guard let left = Double(string[0]), let right = Double(string[2]) else {
            return [""]
        }
        
        let equationOperand = string[1]
        var result: Double = 0.0
        
        switch equationOperand {
        case "+":
            result = operation(left: left, operand: .addition, right: right)
        case "-":
            result = operation(left: left, operand: .substraction, right: right)
        default:
            fatalError("Unknown operator !")
        }
        string = Array(string.dropFirst(3))
        string.insert(String(result), at: 0)
        return string
    }
    
    
    
    private func priorityCalcul(equation: [String]) -> [String]/*Result<[String], ErrorType>*/ {
        
        var string = equation
        
        while (string.firstIndex(of: Operator.multiplication.rawValue) != nil) || string.firstIndex(of: Operator.division.rawValue) != nil {
            
            if (string.firstIndex(of: Operator.multiplication.rawValue) != nil) {
                priorityOperand = Operator.multiplication.rawValue
                operand = .multiplication
            }
            else if (string.firstIndex(of: Operator.division.rawValue) != nil){
                priorityOperand = Operator.division.rawValue
                operand = .division
            }
            
            guard
                let n = string.firstIndex(of: priorityOperand),
                let left = Double(string[n-1]),
                let right = Double(string[n+1])
            else {
                return [""]
            }
            
            if operand == .multiplication {
                string[n-1] = String(operation(left: left, operand: operand, right: right))
                string.remove(at: n)
                string.remove(at: n)
            } else if operand == .division && right != 0 {
                string[n-1] = String(operation(left: left, operand: operand, right: right))
                string.remove(at: n)
                string.remove(at: n)
            }
            else if operand == .division && right == 0 {
                string = ["errorDivision0"]
                //return .failure(ErrorType.division0)
            }
        }
        return string
    }
    
    
    private func operation (left: Double, operand: Operator, right: Double) -> Double {
        
        var result: Double = 0.0
        
        switch operand {
        case .addition:
            result = left + right
        case .substraction:
            result = left - right
        case .multiplication:
            result = left * right
        case .division:
            result = left / right
        }
        return result
    }
    
    
    private func isMultiOperatorsEquation(equation: [String]) -> Bool {
        
        var result: Int = 0
        var n: Int = 0
        for i in stride(from: equation.startIndex, to: equation.endIndex, by: 3) {
            while n < i + 3 && n < equation.endIndex {
                if LogicCalcul.isOperator(string: equation[n]) {
                    if LogicCalcul.isOperator(string: equation[n+1]) {
                        result += 1
                    }
                }
                n += 1
            }
        }
        return result != 0
    }
    
    
    static func isOperator(string: String?) -> Bool {
        
        guard let string = string else {
            return false
        }
        
        return string == Operator.addition.rawValue ||
            string == Operator.substraction.rawValue ||
            string == Operator.multiplication.rawValue ||
            string == Operator.division.rawValue
    }
}
