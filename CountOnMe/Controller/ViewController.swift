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
    
    /*var expressionHaveResult: Bool {
        calculatorView.textView.text.firstIndex(of: "=") != nil
    }*/
    
    
    // MARK: - OVERRIDED METHODS
    
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
        
        if calculatorView.expressionHaveResult || calculatorView.textView.text == "0" {
            calculatorView.clear()
        }
        
        calculatorView.textView.text.append(numberText)
        updateTextFont()
    }
    
    private func didTappedEqualButton() {
        
        guard !logic
                .isOperator(string: calculatorView.elements.last) else {
            errorMessage(element: .noCorrect)
            return
        }
        
        let result = logic.compute(string: calculatorView.elements)
        switch result {
        case .success(let double):
            viewUpdate(double: double)
        case .failure(let error):
            errorMessage(element: error)
            didDeleteLastEntry()
        }
        updateTextFont()
    }
    
    private func didTappedDecimalPointButton() {
        guard !logic.isDecimal(string: calculatorView.elements.last) else {
            errorMessage(element: .multiDecimalPoint)
            return
        }
        
        calculatorView.textView.text.append(".")
        updateTextFont()
    }
    
    private func didDeleteLastEntry() {
        guard !calculatorView.elements.isEmpty else {
            calculatorView.printZero()
            return
        }
        calculatorView.deleteLastCharacter()
    }
    
    private func didTappedOperandButton(_ sender: UIButton) {
        
        guard !logic.isOperator(string: calculatorView.elements.last) else {
            errorMessage(element: .multiOperator)
            return
        }
        
        guard let witchOperand = sender.title(for: .normal) else {
            return
        }
        
        calculatorView.textView.text.append(" \(witchOperand) ")
        updateTextFont()
    }
    
    private func errorMessage(element: ErrorType) {
        displayAlert(message: element.message)
    }
    
    private func updateTextFont() {
        if (calculatorView.textView.text.isEmpty || calculatorView.textView.bounds.size.equalTo(CGSize.zero)) {
            return
        }
        
        let textViewSize = calculatorView.textView.frame.size
        let fixedWidth = textViewSize.width
        let expectSize = calculatorView.textView.sizeThatFits(CGSize(width: fixedWidth, height: CGFloat(MAXFLOAT)))

        var expectFont = calculatorView.textView.font
        if (expectSize.height > textViewSize.height) {
            while (calculatorView.textView.sizeThatFits(CGSize(width: fixedWidth, height: CGFloat(MAXFLOAT))).height > textViewSize.height) {
                expectFont = calculatorView.textView.font!.withSize(calculatorView.textView.font!.pointSize - 1)
                calculatorView.textView.font = expectFont
            }
        }
    }
}
