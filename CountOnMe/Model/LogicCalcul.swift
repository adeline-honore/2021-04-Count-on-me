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
    
    private enum Operator: String {
        case addition = "+"
        case substraction = "-"
        case multiplication = "x"
        case division = "/"
    }
    
    // MARK: - PROPRETIES
    
    private var operand: Operator = .addition
    private var priorityOperand = ""
    
    
    // MARK: - METHODS
    
    func compute(string: [String]) -> Result<String, ErrorType> {
        
        var result: [String] = string
        
        
        guard !isOperator(string: string.last) else {
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
        
        return .success(result[0])
    }
    
    
    private func simpleCalcul(equation: [String]) -> [String] {
        
        var string = equation
        
        guard let left = Float(string[0]) else {
            return [""]
        }
        
        guard let right = Float(string[2]) else {
            return [""]
        }
        
        let equationOperand = string[1]
        var result: Float = 0.0
        
        switch equationOperand {
        case "+":
            result = operation(left: Float(Int(left)), operand: .addition, right: Float(Int(right)))
        case "-":
            result = operation(left: Float(Int(left)), operand: .substraction, right: Float(Int(right)))
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
                let left = Float(string[n-1]),
                let right = Float(string[n+1])
            else {
                //return .failure(ErrorType.division0)
                return [""]
            }
            
            if operand == .multiplication {
                string[n-1] = String(operation(left: Float(Int(left)), operand: operand, right: Float(Int(right))))
                string.remove(at: n)
                string.remove(at: n)
                //return .success(string)
            } else if operand == .division && right != 0 {
                string[n-1] = String(operation(left: Float(Int(left)), operand: operand, right: Float(Int(right))))
                string.remove(at: n)
                string.remove(at: n)
                //return .success(string)
            }
            else if operand == .division && right == 0 {
                string = ["errorDivision0"]
                //return .failure(ErrorType.division0)
            }
        }
        return string
    }
    
    
    private func operation (left: Float, operand: Operator, right: Float) -> Float {
        
        var result: Float = 0.0
        
        //resultat = left Operand.RawValue right
        
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
    
    
    private func isOperator(string: String?) -> Bool {
        
        guard let string = string else {
            return false
        }
        
        return string == Operator.addition.rawValue ||
            string == Operator.substraction.rawValue ||
            string == Operator.multiplication.rawValue ||
            string == Operator.division.rawValue
    }
}


/*
 
 var p = priorityCalcul(equation: string)
 print(p)
 
 
 
 if p == . success(<#T##[String]#>) {
 
 } else {
 return .failure(ErrorType.division0)
 }
 
 
 if p == .failure(ErrorType.division0) {
 return .failure(ErrorType.division0)
 } else {
 
 }
 
 
 if priorityCalcul(equation: string) == .failure(ErrorType.division0) {
 return .failure(ErrorType.division0)
 } else {
 result = simpleCalcul(equation: priorityCalcul(equation: result).)
 }
 
 if simpleCalcul(equation: result) == [""] {
 return .success(result[0])
 }
 
 
 
 isMultiOperatorsequation(equation: string) ? return .failure(ErrorType.multiOperator);  result = string
 
 if string != ["error multi-operateur"] {
 // PriorityCalcul
 result = priorityCalcul(equation: string)
 
 if string.isEmpty {
 string = string
 }
 
 
 
 
 while result.count > 1 {
 simpleCalcul
 string = simpleCalcul(equation: string)
 }
 
 
 
 /*guard !string[0].contains("error multi-operateur") else {
 return .failure(ErrorType.multiOperator)
 }*/
 
 */
