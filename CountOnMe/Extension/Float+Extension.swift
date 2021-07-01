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
        print("je suis dans l' extension")
        let formatter = NumberFormatter()
        let number = NSNumber(value: self)
        formatter.minimumFractionDigits = 0
        formatter.maximumFractionDigits = 9
        
        return String(formatter.string(from: number) ?? "")
    }
}


/*
 
 import Foundation
 extension Double {
     func removeZerosFromEnd() -> String {
         let formatter = NumberFormatter()
         let number = NSNumber(value: self)
         formatter.minimumFractionDigits = 0
         formatter.maximumFractionDigits = (self.components(separatedBy: ".").last)!.count
         return String(formatter.string(from: number) ?? "")
     }
 }
 
 
 */
