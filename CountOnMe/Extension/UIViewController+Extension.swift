//
//  UIViewController+Extension.swift
//  CountOnMe
//
//  Created by HONORE Adeline on 04/05/2021.
//  Copyright © 2021 Vincent Saluzzo. All rights reserved.
//

import UIKit

// MARK: - EXTENSIONS


extension UIViewController {
    func displayAlert(title: String, message: String) {
        
        let alertVC = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alertVC.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        return present(alertVC, animated: true, completion: nil)
    }
}


/*
// Error check computed variables
extension UIViewController(title, message) {
    func alertVC(_ sender: Bool) {
        
        var messageToInsert: String = ""
        
        if sender == canAddOperator {
            messageToInsert = "Un operateur est déja mis !"
        }
        else if sender == expressionHaveEnoughElement {
            messageToInsert = "Démarrez un nouveau calcul !"
        }
        else if sender == expressionIsCorrect {
            messageToInsert = "Entrez une expression correcte !"
        }
        else if sender == divisionImpossible {
            messageToInsert = "La division par 0 est impossible"
        }
        
        
        let alertVC = UIAlertController(title: "Zéro!", message: messageToInsert, preferredStyle: .alert)
        alertVC.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
        return self.present(alertVC, animated: true, completion: nil)
    }
}
 
 
 

 var expressionIsCorrect: Bool {
    return elements.last != "+" && elements.last != "-"
 }
 
 var expressionHaveEnoughElement: Bool {
     return elements.count >= 3
 }
 
 var canAddOperator: Bool {
     return elements.last != "+" && elements.last != "-"
 }
 
 var expressionHaveResult: Bool {
     return textView.text.firstIndex(of: "=") != nil
 }
 
 var divisionImpossible: Bool {
     return false
 }
*/

