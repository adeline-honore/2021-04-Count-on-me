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
    
    
    // MARK: - OVERIDED METHODS
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func loadView() {
        super.loadView()
        calculatorView = view as? CalculatorView
    }
    
    // MARK: - IBActions
    @IBAction func newCalculation() {
        calculatorView.printZero()
    }
    
    @IBAction func deleteLastEntry() {
        didDeleteLastEntry()
    }
    
    @IBAction func tappedEqualButton() {
        didTappedEqualButton()
    }
    
    @IBAction func tappedNumberButton(_ sender: UIButton) {
        didTappedNumberButton(sender)
    }
    
    @IBAction func tappedOperandButton(_ sender: UIButton) {
        didTappedOperandButton(sender)
    }
    
    @IBAction func tappedDecimalPointButton() {
        didTappedDecimalPointButton()
    }
    
    // MARK: - other METHODS
    
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
    
    private func didTappedEqualButton() {
        
        guard !LogicCalcul.isOperator(string: calculatorView.elements.last) else {
            errorMessage(element: .noCorrect)
            return
        }
        
        let result = logic.compute(string: calculatorView.elements)
        switch result {
        case .success(let double):
            viewUpdate(double: double)
        case .failure(let error):
            errorMessage(element: error)
        }
    }
    
    private func didTappedDecimalPointButton() {
        guard !LogicCalcul.isDecimal(string: calculatorView.elements.last) else {
            errorMessage(element: .multiDecimalPoint)
            return
        }
        
        calculatorView.textView.text.append(".")
    }
    
    private func didDeleteLastEntry() {
        guard !calculatorView.elements.isEmpty else {
            calculatorView.printZero()
            return
        }
        calculatorView.deleteLastCharacter()
    }
    
    private func didTappedOperandButton(_ sender: UIButton) {
        
        guard !LogicCalcul.isOperator(string: calculatorView.elements.last) else {
            errorMessage(element: .multiOperator)
            return
        }
        
        guard let witchOperand = sender.title(for: .normal) else {
            return
        }
        
        calculatorView.textView.text.append(" \(witchOperand) ")
    }
    
    private func errorMessage(element: ErrorType) {
        displayAlert(message: element.message)
    }
}
