//
//  LogicCalcul.swift
//  CountOnMe
//
//  Created by HONORE Adeline on 06/05/2021.
//  Copyright © 2021 Vincent Saluzzo. All rights reserved.
//

import Foundation

class LogicCalcul {
    
    // MARK: - PROPRETIES
    
    private var operand: Operator = .addition
    
    // MARK: - METHODS
    
    func compute(string: [String]) -> Result<Double, ErrorType> {
        
        var result: [String] = string
        
        guard !isOperator(string: string.last) else {
            return .failure(ErrorType.noCorrect)
        }
        
        guard !isMultiOperatorsEquation(equation: string) else {
            return .failure(ErrorType.multiOperator)
        }
        
        guard !isMultiDecimalPoint(equation: string) else {
            return .failure(ErrorType.multiDecimalPoint)
        }
        
        guard !isDivision0(equation: string) else {
            return .failure(ErrorType.division0)
        }
        
        while result.contains(Operator.multiplication.rawValue) || result.contains(Operator.division.rawValue) {
            result = priorityCalcul(equation: result)
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
        case Operator.addition.rawValue:
            result = operation(left: left, operand: .addition, right: right)
        case Operator.substraction.rawValue:
            result = operation(left: left, operand: .substraction, right: right)
        default:
            fatalError("Unknown operator !")
        }
        string = Array(string.dropFirst(3))
        string.insert(String(result), at: 0)
        return string
    }
    
    
    
    private func priorityCalcul(equation: [String]) -> [String] {
        
        var string = equation
        
        if string.firstIndex(of: Operator.multiplication.rawValue) != nil {
            operand = .multiplication
        }
        else if string.firstIndex(of: Operator.division.rawValue) != nil {
            operand = .division
        }
        
        guard
            let n = string.firstIndex(of: operand.rawValue),
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
                if isOperator(string: equation[n]) {
                    if isOperator(string: equation[n+1]) {
                        result += 1
                    }
                }
                n += 1
            }
        }
        return result != 0
    }
    
    private func isDivision0(equation: [String]) -> Bool {
        var result: Int = 0
        var indexElement: Int = 0
        
        for element in equation {
            /*guard */let next = equation[equation.index(after: indexElement)] /*else {
                return false
            }*/
            
            if element == Operator.division.rawValue && next == String(Int(0)) || next == String(Float(0)) {
                result += 1
            }
            indexElement += 1
        }
        return result != 0
    }
    
    private func isMultiDecimalPoint(equation: [String]) -> Bool {
        
        var result: Int = 0
        
        for element in equation {
            var decimal: Int = 0
            element.forEach { char in
                if isDecimal(string: String(char)) {
                    decimal += 1
                }
                
                if decimal > 1 {
                    result += 1
                }
            }
        }
        return result != 0
    }
    
    func isOperator(string: String?) -> Bool {
        
        guard let string = string else {
            return false
        }
        
        return string == Operator.addition.rawValue ||
            string == Operator.substraction.rawValue ||
            string == Operator.multiplication.rawValue ||
            string == Operator.division.rawValue
    }
    
    func isDecimal(string: String?) -> Bool {
        
        guard let string = string else {
            return false
        }
        
        return string.contains(".")
    }
}
