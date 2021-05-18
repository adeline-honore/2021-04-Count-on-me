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
        
    // MARK: - METHODS
    
    // View Life cycles
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    override func loadView() {
        
        super.loadView()
        let calculatorView = CalculatorView()
        self.calculatorView = calculatorView
        
        //view as! CalculatorView
        //calculatorView = view as? CalculatorView
        //view = CalculatorView()
    }
    
    
    
    @IBAction func newCalculation() {
        calculatorView.clear()
        
    }
    
    @IBAction func delLastEntry() {
        // mettre une boucle for pour parcourir le tableau et savoir si il s'agit d'un chiffre ou un operateur car si O : remove 3
        calculatorView.textView.text.remove(at: calculatorView.textView.text.index(before: calculatorView.textView.text.endIndex))
    }
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    @IBAction func tappedEqualButton() {
        
        /*guard expressionIsCorrect else {
            //alertVC(expressionIsCorrect)
            print("no correct")
            return
        }*/
        
        logic.didTappedEqualButton(string: calculatorView.elements)
        
        //calculatorView.textView.text.append(" = \(logic.resultToPrint)")
        
    }
    
    
    var expressionHaveEnoughElement: Bool {
        return calculatorView.elements.count >= 3
    }
    
    /*var expressionHaveResult: Bool {
        return calcul.textView.text.firstIndex(of: "=") != nil
    }*/
    
    var canAddOperator: Bool {
        //return calculation.elements.last != "+" && calculation.elements.last != "-"
        return calculatorView.textView.text.last != "+" && calculatorView.textView.text.last != "-"
    }
    
    
    
    
    
    
    
    // View actions
    @IBAction func tappedNumberButton(_ sender: UIButton) {
        didTappedNumberButton(sender)
    }
    
    private func didTappedNumberButton(_ sender: UIButton) {
        
        //var textView = calcul.textView.text
        
        /*guard let textView = calcul.textView else {
            print("nulll")
            calcul.textView.text = ""
        }*/
        
        guard let numberText = sender.title(for: .normal) else {
            return
        }
        
        /*if expressionHaveResult == false {
            calcul.textView.text = ""
        }
        calcul.textView.text.append(numberText)*/
        
        
        if /*calcul.textView.text.firstIndex(of: "=") != nil*/ calculatorView.textView == nil {
            print("sdfgh")
            //textV?.text = ""
            //print(textView)
            print("tre")
            calculatorView.textView.text.firstIndex(of: "=") != nil
            calculatorView.textView.text.append(numberText)
        }
        else {
            print("etetetete \(calculatorView.textView.text)")
            //calcul.textView.text.append(numberText)
            calculatorView.textView.text.append(numberText)
        }
        
        
    }
    
    
    @IBAction func tappedOperandButton(_ sender: UIButton) {
        
        guard let witchOperand = sender.title(for: .normal) else {
            return
        }
        
        //textView.text.append(" \(witchOperand) ")
        
        if canAddOperator {
            calculatorView.textView.text.append(" \(witchOperand) ")
        } else {
            displayAlert(title: "Oups !", message: "You can not add operand")
        }
    }
    
}





