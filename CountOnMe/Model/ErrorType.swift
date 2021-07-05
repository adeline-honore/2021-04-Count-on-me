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
    case other
    
    var message: String {
        switch self {
        case .division0:
            return "Pas un nombre"
        case .multiOperator:
            return "succession d'opérateurs, calcul impossible"
        case .noCorrect:
            return "élements manquants dans le calcul"
        case .other:
            return "autre erreur"
            
        }
    }
}
