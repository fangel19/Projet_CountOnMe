//
//  ViewController.swift
//  SimpleCalc
//
//  Created by Vincent Saluzzo on 29/03/2019.
//  Copyright © 2019 Vincent Saluzzo. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    // MARK: - Outlet var
    
    @IBOutlet weak var textView: UITextView!
    @IBOutlet var numberButtons: [UIButton]!
    
    var calculator = Calculator()
    
    var elements: [String] {
        return textView.text.split(separator: " ").map { "\($0)" }
    }
    
    var expressionHaveResult: Bool {
        return textView.text.firstIndex(of: "=") != nil
    }
    
    // MARK: - viewDidLoad
    
    override func viewDidLoad() {
        super.viewDidLoad()
        calculator.delegate = self
        // Do any additional setup after loading the view.
    }
    
    
    // MARK: - NumberButton
    
    @IBAction func tappedNumberButton(_ sender: UIButton) {
        guard let numberText = sender.title(for: .normal) else {
            return
        }
        
        if expressionHaveResult {
            textView.text = ""
        }
        
        textView.text.append(numberText)
    }
    
    // MARK: - Operator
    
    @IBAction func tappedAdditionButton(_ sender: UIButton) {
        guard calculator.expressionDontHaveOpatorFirst(elements: elements) else {
            alertMessage("Entrer un nombre !")
            return
        }
        if calculator.canAddOperator(elements: elements) {
            textView.text.append(" + ")
        } else {
            alertMessage("Un operateur est déja mis !")
        }
    }
    
    @IBAction func tappedSubstractionButton(_ sender: UIButton) {
        guard calculator.expressionDontHaveOpatorFirst(elements: elements) else {
            alertMessage("Entrer un nombre !")
            return
        }
        if calculator.canAddOperator(elements: elements) {
            textView.text.append(" - ")
        } else {
            alertMessage("Un operateur est déja mis !")
        }
        
    }
    
    @IBAction func tappedMultiplicationButton(_ sender: UIButton) {
        guard calculator.expressionDontHaveOpatorFirst(elements: elements) else {
            alertMessage("Entrer un nombre !")
            return
        }
        if calculator.canAddOperator(elements: elements) {
            textView.text.append(" x ")
        } else {
            alertMessage("Un operateur est déja mis !")
        }
    }
    
    @IBAction func tappedDivisionButton(_ sender: UIButton) {
        guard calculator.expressionDontHaveOpatorFirst(elements: elements) else {
            alertMessage("Entrer un nombre !")
            return
        }
        if calculator.canAddOperator(elements: elements) {
            textView.text.append(" / ")
        } else {
            alertMessage("Un operateur est déja mis !")
        }
    }
    
    @IBAction func tappedAcButton(_ sender: UIButton) {
        textView.text = ""
    }
    
    
    @IBAction func tappedEqualButton(_ sender: UIButton) {
        guard calculator.expressionIsCorrect(elements: elements) else {
            alertMessage("Entrez une expression correcte !")
            return
        }
        
        guard calculator.expressionHaveEnoughElement(elements: elements) else {
            alertMessage("Ajouter votre calcul !")
            return
        }
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
            case "/": result = calculator.division(left: left, right: right)
                
                
            default: alertMessage("Demarrez un nouveau calcul")
                return tappedNumberButton(sender)
            }
            for _ in 1...3 {
                operationsToReduce.remove(at: place)
            }
            
            operationsToReduce.insert("\(result)", at: place)
            
        }
        textView.text.append(" = \(operationsToReduce.first!)")
        
    }
}
// MARK: - Extension

extension ViewController: AlertDelagate {
    func alertMessage(_ message: String) {
        let alertVC = UIAlertController(title: "Erreur!", message: message, preferredStyle: .alert)
        alertVC.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
        return self.present(alertVC, animated: true, completion: nil)
    }
    
    
}
