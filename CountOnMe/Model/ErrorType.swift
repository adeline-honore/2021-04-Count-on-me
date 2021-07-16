//
//  ErrorType.swift
//  CountOnMe
//
//  Created by HONORE Adeline on 22/06/2021.
//  Copyright © 2021 Vincent Saluzzo. All rights reserved.
//

import Foundation

enum ErrorType: Error {
    case division0
    case multiOperator
    case noCorrect
    case multiDecimalPoint
    case other
    
    var message: String {
        switch self {
        case .division0:
            return "Division par 0 impossible! Pas un nombre"
        case .multiOperator:
            return "Succession d'opérateurs, calcul impossible"
        case .noCorrect:
            return "Èlements manquants dans le calcul"
        case .multiDecimalPoint:
            return "Succession de virgules, calcul impossible"
        case .other:
            return "Autre erreur"
            
        }
    }
}
