//
//  ViewController.swift
//  SimpleCalc
//
//  Created by Vincent Saluzzo on 29/03/2019.
//  Copyright © 2019 Vincent Saluzzo. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var textView: UITextView!
    @IBOutlet var numberButtons: [UIButton]!
    
    var elements: [String] {
        return textView.text.split(separator: " ").map { "\($0)" }
    }
    
    // Error check computed variables
    var expressionIsCorrect: Bool {
        return elements.last != "+" && elements.last != "-" && elements.last != "x" && elements.last != "/"
    }
    
    var expressionHaveEnoughElement: Bool {
        return elements.count >= 3
    }
    
    var canAddOperator: Bool {
        return elements.last != "+" && elements.last != "-" && elements.last != "x" && elements.last != "/"
    }
    
    var expressionHaveResult: Bool {
        return textView.text.firstIndex(of: "=") != nil

    }

    
    
    // View Life cycles
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    
    // View actions
    @IBAction func tappedNumberButton(_ sender: UIButton) {
        guard let numberText = sender.title(for: .normal) else {
            return
        }
        
        if expressionHaveResult {
            textView.text = ""
        }
        
        textView.text.append(numberText)
    }
    
    @IBAction func tappedAdditionButton(_ sender: UIButton) {
            guard expressionDontHaveOpatorFirst else {
                alertMessage(message: "Entrer un nombre !")
                return
        }
        if canAddOperator {
            textView.text.append(" + ")
        } else {
            alertMessage(message: "Un operateur est déja mis !")
        }
    }
    
    @IBAction func tappedSubstractionButton(_ sender: UIButton) {
        guard expressionDontHaveOpatorFirst else {
            alertMessage(message: "Entrer un nombre !")
            return
    }
        if canAddOperator {
            textView.text.append(" - ")
        } else {
            alertMessage(message: "Un operateur est déja mis !")
        }
        
    }
    
    @IBAction func tappedMultiplicationButton(_ sender: UIButton) {
        guard expressionDontHaveOpatorFirst else {
            alertMessage(message: "Entrer un nombre !")
            return
    }
        if canAddOperator {
            textView.text.append(" x ")
        } else {
            alertMessage(message: "Un operateur est déja mis !")
        }
    }
    
    @IBAction func tappedDivisionButton(_ sender: UIButton) {
        guard expressionDontHaveOpatorFirst else {
            alertMessage(message: "Entrer un nombre !")
            return
    }
        if canAddOperator {
            textView.text.append(" / ")
        } else {
            alertMessage(message: "Un operateur est déja mis !")
        }
    }
    
    @IBAction func tappedAcButton(_ sender: UIButton) {
            textView.text = ""
    }
    
    var expressionDontHaveOpatorFirst: Bool {
        return elements.count >= 1
    }
//  research
    
//    func operandIsCorrect() -> Bool {
//
//        var operand = canAddOperator
//        return textView.text.firstIndex(of: canAddOperator) != nil

//        if let index = operand.first >= 1 {
//        return true
//
//            }
//        return false
    
//    func operandNotFirst() {
//        if elements.first == "+" {
//            alertMessage(message: "Ajouter un chiffre")
//        }
//        return elements.first != "+" && elements.first != "-" && elements.first != "x" && elements.first != "/"
//
//        guard expressionHaveEnoughElement else {
//            alertMessage(message: "Ajouter un chiffre !")
//            return
//        }
//        var expressionIsNotCorrect: Bool {
//            return elements.first == "+" && elements.first == "-" && elements.first == "x" && elements.first == "/"
//        }

    
//        if textView.text.append(" - \(operationsToReduce.first!)") {
 
//        if textView.text.first == "+" {
//        } else {
//            alertMessage(message: "Ajouter un chiffre !")
//            return
//        }
        
//        if textView.text.first = canAddOperator.alertMessage(message: "Ajouter un chiffre !") {
//        if textView.text.append(" - \(operationsToReduce.first!)") != nil {
//
//        }
//        guard expressionHaveEnoughElement else {
//            alertMessage(message: "Ajouter un chiffre !")
//            return
            //            var operand = "-" || "=" || "+" || "/" || "x"
                 //            if operationsToReduce.first! = operand {
//        }


    
    func alertMessage(message: String) {
        let alertVC = UIAlertController(title: "Erreur!", message: message, preferredStyle: .alert)
        alertVC.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
        return self.present(alertVC, animated: true, completion: nil)
    }
    
    func division(left: Double, right: Double) -> Double {
        let result = Double(left / right)
        if right == 0 {
            alertMessage(message: "Ne peut pas être divisible par 0")
        }
        return result
    }
    
    //    func divisionB(division: Bool) -> (Int, Int) -> Float {
    //        func div(left: Int, right: Int) -> Float {
    //            let result = Float(left / right)
    //            if right == 0 {
    //                alertMessage(message: "Ne peut pas être divisible par 0")
    //            } else {
    //            return result
    //        }
    //    }
    //    }
    
    @IBAction func tappedEqualButton(_ sender: UIButton) {
        guard expressionIsCorrect else {
            alertMessage(message: "Entrez une expression correcte !")
            return
        }
        
        guard expressionHaveEnoughElement else {
            alertMessage(message: "Ajouter votre calcul !")
            return
        }
        // Create local copy of operations
        var operationsToReduce = elements
        while operationsToReduce.count > 1 {
            var place = 0
            if let index = operationsToReduce.firstIndex(where: { $0 == "x" || $0 == "/"}) {
                place = index - 1
                
            }
            let left = Double(operationsToReduce[place])!
            let operand = operationsToReduce[place + 1]
            let right = Double(operationsToReduce[place + 2])!
            
            var result: Double = 0.00
            switch operand {
            case "+": result = left + right
            case "-": result = left - right
            case "x": result = left * right
            case "/": result = left / right
                
                
            default: fatalError("Unknown operator !")
            }
            for _ in 1...3 {
                operationsToReduce.remove(at: place)
            }
            
            operationsToReduce.insert("\(result)", at: place)
            
        }
        textView.text.append(" = \(operationsToReduce.first!)")

    }
}
