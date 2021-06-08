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
            
    enum errorType: Error {
        case division0
        case multiOperaor
    }
    
    private enum Operator: String {
        case addition = "+"
        case substraction = "-"
        case multiplication = "x"
        case division = "/"
    }
    
    private var operand: Operator = .addition
    
    private var operationsToReduce: [String] = [""]
    
    private var priorityOperand = ""
    
    
    // MARK: - METHODS
    
   
    
    func compute(string: [String]) -> Result<String,errorType> {
        
        var resultat: [String] = [""]
                            
        // PriorityCalcul
        resultat = priorityCalcul(equation: string)
                    
        if resultat == [] {
            resultat = string
        }
        
        while resultat.count > 1 {
            
            // simpleCalcul
            resultat = simpleCalcul(equation: resultat)
        }
        
        //let a = resultat[0]
        
        guard !resultat[0].contains("error") else {
            return .failure(.division0)
            }
            return .success(resultat[0])
        
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
                let left = Int(string[n-1]),
                let right = Int(string[n+1])
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
                print("Pas un nombre")
                string = ["errorDivision0"]
            }
        }
        return string
    }
    
    
    private func operation (left: Int, operand: Operator, right: Int) -> Int {
        
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
    /*
    private func multiOperatorsequation(equation: [String]) -> [String] {
        var string = equation
        //on parcourt le tableau de string et tant qu'on trouve en first index un opérateur et que le + est aussi un opérateur alors error
        while ((string.firstIndex(of: Operator.RawValue)) != nil) {
            <#code#>
        }
        
        return string
    }*/
}
