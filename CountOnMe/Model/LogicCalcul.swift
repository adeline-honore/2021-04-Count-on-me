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
    
    //private let additionOperand = "+"
    //private let substractionOperand = "-"
    //private let multiplicationOperand = "x"
    //private let divisionOperand = "/"
    private var priorityOperand = ""
    
    
    // MARK: - METHODS
    
   
    
    func didTappedEqualButton(string: [String]) -> String {
        var result: [String] = [""]
        
        // Iterate over operations while an operand still here
        while operationsToReduce.count > 1 {
            
            // PriorityCalcul
            result = priorityCalcul(equation: operationsToReduce)
        }
        
        while operationsToReduce.count > 1 {
            
            // simpleCalcul
            result = simpleCalcul(equation: operationsToReduce)
        }
        
        return result[0]
    }
    
    
    
    
    private func simpleCalcul(equation: [String]) -> [String] {
        
        guard let left = Int(equation[0]) else {
            return [""]
        }
        
        guard let right = Int(equation[2]) else {
            return [""]
        }
        
        let equationOperand = equation[1]
        var result: Int = 0
        
        switch equationOperand {
        case "+":
            result = operation(left: left, operand: .addition, right: right)
        case "-":
            result = operation(left: left, operand: .substraction, right: right)
        default:
            fatalError("Unknown operator !")
        }
        
        operationsToReduce = Array(equation.dropFirst(3))
        
        return operationsToReduce
    }
    
    
    
    private func priorityCalcul(equation: [String]) -> [String] {
        
        while (equation.firstIndex(of: Operand.multiplication.rawValue/*multiplicationOperand*/ ) != nil) || equation.firstIndex(of: Operand.division.rawValue/*divisionOperand*/) != nil {
            
            if (equation.firstIndex(of: Operand.multiplication.rawValue/*multiplicationOperand*/) != nil) {
                priorityOperand = Operand.multiplication.rawValue/*multiplicationOperand*/
                operand = .multiplication
            }
            else if (equation.firstIndex(of: Operand.division.rawValue/*divisionOperand*/) != nil){
                priorityOperand = Operand.division.rawValue/*divisionOperand*/
                operand = .division
            }
            
            guard let n = equation.firstIndex(of: priorityOperand) else {
                return [""]
            }
            
            guard let left = Int(equation[n-1]) else {
                return [""]
            }
            guard let right = Int(equation[n+1]) else {
                return [""]
            }
                        
            operationsToReduce[n-1] = String(operation(left: left, operand: operand, right: right))
            operationsToReduce.remove(at: n)
            operationsToReduce.remove(at: n)
        }
        return operationsToReduce
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
