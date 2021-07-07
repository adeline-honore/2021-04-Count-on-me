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
        truncatingRemainder(dividingBy: 1) == 0 ? String(format: "%.0f", self) : String(self)
    }
}

