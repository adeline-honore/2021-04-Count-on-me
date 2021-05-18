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
    
    var canAddOperator: Bool {
        //return calculation.elements.last != "+" && calculation.elements.last != "-"
        return calculatorView.textView.text.last != "+" && calculatorView.textView.text.last != "-" && calculatorView.textView.text.last != "x" && calculatorView.textView.text.last != "/"
    }
    
    var expressionIsCorrect: Bool {
        return calculatorView.textView.text.last != "+" && calculatorView.textView.text.last != "-"
    }
    
    var divisionImpossible: Bool {
        return false
    }
    
    
    // MARK: - METHODS
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    override func loadView() {
        super.loadView()
        let calculatorView = CalculatorView()
        self.calculatorView = calculatorView
    }
    
    // View actions
    @IBAction func newCalculation() {
        calculatorView.clear()
    }
    
    @IBAction func delLastEntry() {
        calculatorView.del()
    }
    
    @IBAction func tappedEqualButton() {
        
        guard expressionIsCorrect else {
            //alertVC(expressionIsCorrect)
            displayAlert(title: "Oups !", message: "no correct")
            //print("no correct")
            return
        }
        
        let result = logic.didTappedEqualButton(string: calculatorView.elements)
        
        
        viewUpdate(string: result)
    }
    
    
    
    @IBAction func tappedNumberButton(_ sender: UIButton) {
        didTappedNumberButton(sender)
    }
    
    @IBAction func tappedOperandButton(_ sender: UIButton) {
        
        guard let witchOperand = sender.title(for: .normal) else {
            return
        }
                
        if canAddOperator {
            calculatorView.textView.text.append(" \(witchOperand) ")
        } else {
            displayAlert(title: "Oups !", message: "You can not add operand")
        }
    }
    
    
    private func viewUpdate(string: String) {
        calculatorView.printResult(string: string)
    }
    
    
    private func divisionImposible() {
        
        // si la valeur du dernier indice est / alors displayalert
        // displayAlert(title: "Oups !", message: "division impossible")
        
        if calculatorView.textView.text.last == "/" {
            displayAlert(title: "Oups !", message: "division impossible")
        }
    }
    
    private func didTappedNumberButton(_ sender: UIButton) {
        
        guard let numberText = sender.title(for: .normal) else {
            return
        }
        
        if expressionHaveResult == false {
            print("expre no have result")
            calculatorView.textView.text = ""
        }
        
        if /*calcul.textView.text.firstIndex(of: "=") != nil*/ calculatorView.textView == nil {
            print("sdfgh")
            calculatorView.textView.text.firstIndex(of: "=") != nil
            calculatorView.textView.text.append(numberText)
        }
        else {
            print(numberText)
            calculatorView.textView.text.append(numberText)
        }
        
        // ajouter la division impossible / 0
        if numberText == "0" {
            divisionImposible()
        }
        
        calculatorView.textView.text.append(numberText)
    }
    
}
