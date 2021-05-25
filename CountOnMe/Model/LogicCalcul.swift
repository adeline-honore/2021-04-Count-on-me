//
//  LogicCalcul.swift
//  CountOnMe
//
//  Created by HONORE Adeline on 06/05/2021.
//  Copyright © 2021 Vincent Saluzzo. All rights reserved.
//

import Foundation

class LogicCalcul {
    
    // MARK: - PROPERTIES
            
    
    
    enum Operand: String {
        case addition = "+"
        case substraction = "-"
        case multiplication = "x"
        case division = "/"
    }
    
    private var operand: Operand = .addition
    
    private var operationsToReduce: [String] = [""]
    
    private var priorityOperand = ""
    
    
    // MARK: - METHODS
    
   
    
    func didTappedEqualButton(string: [String]) -> String {
        
        var result: [String] = [""]
                            
        // PriorityCalcul
        result = priorityCalcul(equation: string)
            
        if result == [] {
            result = string
        }
        
        while result.count > 1 {
            
            // simpleCalcul
            result = simpleCalcul(equation: result)
        }
        
        return result[0]
    }
    
    
    
    
    private func simpleCalcul(equation: [String]) -> [String] {
        
        var string = equation
                
        guard let left = Int(string[0]) else {
            return [""]
        }
        
        guard let right = Int(string[2]) else {
            return [""]
        }
                
        let equationOperand = string[1]
        var result: Int = 0
        
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
    
    
    
    private func priorityCalcul(equation: [String]) -> [String] {
        
        var string = equation
        
        while (string.firstIndex(of: Operand.multiplication.rawValue) != nil) || string.firstIndex(of: Operand.division.rawValue) != nil {
            
            if (string.firstIndex(of: Operand.multiplication.rawValue) != nil) {
                priorityOperand = Operand.multiplication.rawValue
                operand = .multiplication
            }
            else if (string.firstIndex(of: Operand.division.rawValue) != nil){
                priorityOperand = Operand.division.rawValue
                operand = .division
            }
            
            guard let n = string.firstIndex(of: priorityOperand) else {
                return [""]
            }
            
            guard let left = Int(string[n-1]) else {
                return [""]
            }
            guard let right = Int(string[n+1]) else {
                return [""]
            }
                        
            string[n-1] = String(operation(left: left, operand: operand, right: right))
            string.remove(at: n)
            string.remove(at: n)
        }
        return string
    }
    
    
    private func operation (left: Int, operand: Operand, right: Int) -> Int {
        
        var resultat: Int = 0
        
        //resultat = left Operand.RawValue right
                
        switch operand {
        case .addition:
            resultat = left + right
        case .substraction:
            resultat = left - right
        case .multiplication:
            resultat = left * right
        case .division:
            resultat = left / right
        }
        return resultat
    }
}
