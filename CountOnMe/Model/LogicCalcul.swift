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
            
    enum ErrorType: Error {
        case division0
        case multiOperator
        
        var message: String {
            switch self {
            case .division0:
                return "Pas un nombre"
            case .multiOperator:
                return "succession d'opérateurs, calcul impossible"
                
            }
        }
    }
    
    private enum Operator: String {
        case addition = "+"
        case substraction = "-"
        case multiplication = "x"
        case division = "/"
    }
    
    // MARK: - PROPRETIES
    
    private var operand: Operator = .addition
    private var operationsToReduce: [String] = [""]
    private var priorityOperand = ""
    
    
    // MARK: - METHODS
    
    func compute(string: [String]) -> Result<String,ErrorType> {
        
        var result: [String] = [""]
        
        result = multiOperatorsequation(equation: string)
        print(result)
        
        if result != ["error multi-operateur"] {
            // PriorityCalcul
            result = priorityCalcul(equation: string)
                        
            if result.isEmpty {
                result = string
            }
            
            while result.count > 1 {
                // simpleCalcul
                result = simpleCalcul(equation: result)
            }
        }
        
        guard !result[0].contains("errorDivision0") else {
            return .failure(ErrorType.division0)
        }
        guard !result[0].contains("error multi-operateur") else {
            return .failure(ErrorType.multiOperator)
        }
            return .success(result[0])
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
    
    // renvoyer un bool et retourner erreur appelr le func isMulti avec un verbe
    private func multiOperatorsequation(equation: [String]) -> [String] {
        // faire une fonction 3 par 3 avec itération de vérif
        var string: [String] = equation
        var stringDic: [Int: String] = [:]
        var cle = 0
        
        for i in string {
            stringDic[cle] = i
            cle += 1
        }
        
        for (key, value) in stringDic {
            
            let indiceAfter = key + 1
            
            if indiceAfter < stringDic.count {
                let s = stringDic[indiceAfter]
               
                if value == Operator.addition.rawValue || value == Operator.substraction.rawValue || value == Operator.multiplication.rawValue || value == Operator.division.rawValue {
                    
                    if s == Operator.addition.rawValue || s == Operator.substraction.rawValue || s == Operator.multiplication.rawValue || s == Operator.division.rawValue {
                        string = ["error multi-operateur"]
                    }
                }
            }
        }
        return string
    }
}
