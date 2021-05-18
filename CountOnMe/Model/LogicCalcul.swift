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
            
    private var operationsToReduce: [String] = [""]
    
    
    // MARK: - METHODS
    
    enum Operand {
        case addition
        case substraction
        case multiplication
        case division
    }
    
    private var operand: Operand = .addition
    
    private let additionOperand = "+"
    private let substractionOperand = "-"
    private let multiplicationOperand = "x"
    private let divisionOperand = "/"
    private var priorityOperand = ""
    
    
    
    func didTappedEqualButton(string: [String]) /* mettre return */ {
        
        // Iterate over operations while an operand still here
        while (operationsToReduce.count > 1) {
            
            // PriorityCalcul
            priorityCalcul(equation: operationsToReduce)
        
            // simpleCalcul
            simpleCalcul(equation: operationsToReduce)
        }
        //return int
    }
    
    
    
    
    private func simpleCalcul(equation: [String]) {
        
        guard let left = Int(equation[0]) else {
            return
        }
        
        guard let right = Int(equation[2]) else {
            return
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
        operationsToReduce.insert("\(result)", at: 0)
    }
    
    
    
    
    
    
    private func priorityCalcul(equation: [String]) {
        
        while (equation.firstIndex(of: multiplicationOperand ) != nil) || equation.firstIndex(of: divisionOperand) != nil {
            
            if (equation.firstIndex(of: multiplicationOperand) != nil) {
                priorityOperand = multiplicationOperand
                operand = .multiplication
            }
            else if (equation.firstIndex(of: divisionOperand) != nil){
                priorityOperand = divisionOperand
                operand = .division
            }
            
            guard let n = equation.firstIndex(of: priorityOperand) else {
                return
            }
            
            guard let left = Int(equation[n-1]) else {
                return
            }
            guard let right = Int(equation[n+1]) else {
                return
            }
                        
            operationsToReduce[n-1] = String(operation(left: left, operand: operand, right: right))
            operationsToReduce.remove(at: n)
            operationsToReduce.remove(at: n)
        }
    }
    
    
    
    private func operation (left: Int, operand: Operand, right: Int) -> Int {
        
        var resultat: Int = 0
        
        switch operand {
        case .addition:
            resultat = left + right
        case .substraction:
            resultat = left - right
        case .multiplication:
            resultat = left * right
        case .division:
            if right != 0 {
                resultat = left / right
            }
            else {
                print("division impossible")
                //alertVC(divisionImpossible)
                //return
            }
        }
        //operand = String(operand)
        return resultat
    }
}
