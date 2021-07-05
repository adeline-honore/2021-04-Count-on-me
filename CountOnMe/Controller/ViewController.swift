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
        
        let result = logic.compute(string: calculatorView.elements)
        switch result {
        case .success(let double):
            viewUpdate(double: double)
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
        
        calculatorView.textView.text.append(numberText)
    }
    
    
    private func errorMessage(element: ErrorType) {
        displayAlert(message: element.message)
    }
}
