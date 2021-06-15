//
//  ViewController.swift
//  SimpleCalc
//
//  Created by Vincent Saluzzo on 29/03/2019.
//  Copyright © 2019 Vincent Saluzzo. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    // MARK: - PROPERTIES
    
    private var calculatorView: CalculatorView!
    private var logic = LogicCalcul()
    
    var expressionHaveEnoughElement: Bool {
        return calculatorView.elements.count >= 3
    }
    
    var expressionHaveResult: Bool {
        return calculatorView.textView.text.firstIndex(of: "=") != nil
        //return calculatorView.elements.firstIndex(of: "=") != nil
    }
    
    /*
    var canAddOperator: Bool {
        //return calculation.elements.last != "+" && calculation.elements.last != "-"
        return calculatorView.textView.text.last != "+" && calculatorView.textView.text.last != "-" && calculatorView.textView.text.last != "x" && calculatorView.textView.text.last != "/"
    }*/
    
    var expressionIsCorrect: Bool {
        return calculatorView.textView.text.last != "+" && calculatorView.textView.text.last != "-"
    }
    
    var divisionImpossible: Bool {
        return false
    }
    
    
    // MARK: - METHODS
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func loadView() {
        super.loadView()
        calculatorView = view as? CalculatorView
    }
    
    // View actions
    @IBAction func newCalculation() {
        calculatorView.printZero()
    }
    
    @IBAction func delLastEntry() {
       
        var array = calculatorView.elements
        print(array)
        
        let lastEntry = array.count - 1
        print(lastEntry)
        
        array.remove(at: lastEntry)
        print(array)
        
        var string: String = ""
        
        for i in array {
            string.append(i)
        }
        
        //string = string.split(separator: " ").map { "\($0)" }
        
        print(string)
        calculatorView.del(string: string)
        
    }
    
    @IBAction func tappedEqualButton() {
        
        guard expressionIsCorrect else {
            //alertVC(expressionIsCorrect)
            //displayAlert(/*title: "Oups !", */message: "no correct")
            //print("no correct")
            return
        }
        
        let result = logic.compute(string: calculatorView.elements)
        switch result {
            case .success(let string):
                viewUpdate(string: string)
            case .failure(let error):
                errorMessage(element: error)
            }
    }
    
    
    @IBAction func tappedNumberButton(_ sender: UIButton) {
        didTappedNumberButton(sender)
    }
    
    @IBAction func tappedOperandButton(_ sender: UIButton) {
        
        guard let witchOperand = sender.title(for: .normal) else {
            return
        }
          
        /*
        if canAddOperator {
            calculatorView.textView.text.append(" \(witchOperand) ")
        } else {
            displayAlert(/*title: "Oups !", */message: "You can not add operand")
        }*/
        
        calculatorView.textView.text.append(" \(witchOperand) ")
    }
    
    
    private func viewUpdate(string: String) {
        calculatorView.printResult(string: string)
    }
    
    /*
    private func divisionImposible() {
        
        // si la valeur du dernier indice est / alors displayalert
        // displayAlert(title: "Oups !", message: "division impossible")
        
        if calculatorView.textView.text.last == "/" {
            displayAlert(/*title: "Oups !", */message: "division impossible")
        }
    }*/
    
    private func didTappedNumberButton(_ sender: UIButton) {
        
        guard let numberText = sender.title(for: .normal) else {
            return
        }
        
        if expressionHaveResult == true || calculatorView.textView.text == "0" {
            calculatorView.clear()
        }
        
        calculatorView.textView.text.append(numberText)
    }
    
    
    private func errorMessage(element: LogicCalcul.ErrorType) {
        displayAlert(message: element.message)
    }
    
}
