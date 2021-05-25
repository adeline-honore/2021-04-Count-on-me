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
        return textView.text.split(separator: " ").map { "\($0)" }
    }
    
    
    
    // MARK: - METHODS
    
    func del() {
        
        let lastEntry = textView.text.endIndex
        
        textView.text.remove(at: lastEntry)
        
        // mettre une boucle for pour parcourir le tableau et savoir si il s'agit d'un chiffre ou un operateur car si O : remove 3
    }
    
    
    func clear() {
        textView.text = ""
    }
    
    
    func printResult(string: String) {
        //operationsToReduce.insert("\(result)", at: 0)
        textView.text.insert(contentsOf: "\(string)", at: textView.text.endIndex)
    }
    
    func printZero() {
        textView.text = "0"
    }
    
}
