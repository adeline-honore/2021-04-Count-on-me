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
        textView.text.split(separator: " ").map { "\($0)" }
    }
    
    var expressionHaveResult: Bool {
        textView.text.firstIndex(of: "=") != nil
    }
    
    // MARK: - METHODS
    
    func deleteLastCharacter() {
        textView.text.remove(at: textView.text.index(before: textView.text.endIndex))
    }
    
    func clear() {
        textView.text = ""
    }
    
    func printResult(string: String) {
        textView.text.append(" = ")
        textView.text.append(string)
    }
    
    func printZero() {
        textView.text = "0"
    }
}
