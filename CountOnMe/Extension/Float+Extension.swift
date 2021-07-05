//
//  Float+Extension.swift
//  CountOnMe
//
//  Created by HONORE Adeline on 29/06/2021.
//  Copyright © 2021 Vincent Saluzzo. All rights reserved.
//

import UIKit

// MARK: - EXTENSIONS

extension Double {
    
    func removeZerosFromEnd() -> String {
        let formatter = NumberFormatter()
        let number = NSNumber(value: self)
        let string = String(self)
        
        formatter.minimumFractionDigits = 0
        formatter.maximumFractionDigits = (string.components(separatedBy: ".").last!.count)
        
        return formatter.string(from: number) ?? "other"
    }
}

