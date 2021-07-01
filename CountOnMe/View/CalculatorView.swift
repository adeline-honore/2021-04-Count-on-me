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

    //@IBOutlet weak var textView: UITextView!
    @IBOutlet weak var textView: UITextView!
    
    var elements: [String] {
        /*didSet {
            textView.text.split(separator: " ").map { "\($0)" }
        }*/
        return textView.text.split(separator: " ").map { "\($0)" }
    }
    
    
    // MARK: - METHODS
    
    func del(element: [String]) {
        
        var array = element
        print(array)
                
        array.remove(at: array.count - 1)
        print(array)
        
        //elements = array.split(separator: " ")
        //textView.text.split(separator: " ")
        
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
