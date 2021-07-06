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
    
    var expressionHaveResult: Bool {
        return calculatorView.textView.text.firstIndex(of: "=") != nil
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
        calculatorView.del(element: calculatorView.elements)
        
        /*var array = calculatorView.elements
         print(array)
         
         let lastEntry = array.count - 1
         
         array.remove(at: lastEntry)
         print(array)
         
         array.split(separator: " ")*/
        
        //calculatorView.elements = array.split(separator: " ")
        
    }
    
    @IBAction func tappedEqualButton() {
        
        guard !isOperator(string: calculatorView.elements.last) else {
            errorMessage(element: .noCorrect)
            //ErrorType.noCorrect
            return
        }
        
        viewUpdate(double: logic.compute(string: calculatorView.elements))
        
        /*
         let result = logic.compute(string: calculatorView.elements)
         switch result {
         case .success(let double):
         viewUpdate(double: double)
         case .failure(let error):
         errorMessage(element: error)
         }*/
    }
    
    
    @IBAction func tappedNumberButton(_ sender: UIButton) {
        didTappedNumberButton(sender)
    }
    
    @IBAction func tappedOperandButton(_ sender: UIButton) {
        
        if isOperator(string: calculatorView.elements.last) {
            errorMessage(element: .multiOperator)
            print("appelle del function")
        }
        
        guard let witchOperand = sender.title(for: .normal) else {
            return
        }
        
        calculatorView.textView.text.append(" \(witchOperand) ")
    }
    
    
    private func viewUpdate(double: Double) {
        calculatorView.printResult(string: double.removeZerosFromEnd())
    }
    
    
    private func didTappedNumberButton(_ sender: UIButton) {
        
        guard let numberText = sender.title(for: .normal) else {
            return
        }
        
        if expressionHaveResult || calculatorView.textView.text == "0" {
            calculatorView.clear()
        }
        
        guard !division0(sender: sender) else {
            return errorMessage(element: .division0)
        }
        
        calculatorView.textView.text.append(numberText)
    }
    
    
    private func errorMessage(element: ErrorType) {
        displayAlert(message: element.message)
    }
    
    private func isOperator(string: String?) -> Bool {
        
        guard let string = string else {
            return false
        }
        
        return string == Operator.addition.rawValue ||
            string == Operator.substraction.rawValue ||
            string == Operator.multiplication.rawValue ||
            string == Operator.division.rawValue
    }
    
    private func division0(sender: UIButton) -> Bool {
        
        return isOperator(string: calculatorView.elements.last) && sender.title(for: .normal) == "0"
    }
    
    
}



/*
 private func isMultiOperatorsEquation(equation: [String]) -> Bool {
 
 var result: Int = 0
 var n: Int = 0
 for i in stride(from: equation.startIndex, to: equation.endIndex, by: 3) {
 while n < i + 3 && n < equation.endIndex {
 if isOperator(string: equation[n]) {
 if isOperator(string: equation[n+1]) {
 result += 1
 }
 }
 n += 1
 }
 }
 return result != 0
 }*/

