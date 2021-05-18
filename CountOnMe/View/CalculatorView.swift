//
//  CalculatorView.swift
//  CountOnMe
//
//  Created by HONORE Adeline on 04/05/2021.
//  Copyright © 2021 Vincent Saluzzo. All rights reserved.
//

import UIKit


class CalculatorView: UIView {
    
    // MARK: - PROPERTIES

    @IBOutlet weak var textView: UITextView!
    
    var elements: [String] {
        return textView.text.split(separator: " ").map { "\($0)" }
    }
    
    
    func clear() {
        print(textView)
        textView.text = ""
    }
    
    
    // MARK: - METHODS
    
}
