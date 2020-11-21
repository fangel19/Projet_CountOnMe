//
//  Calculator.swift
//  CountOnMe
//
//  Created by angelique fourny on 27/10/2020.
//  Copyright © 2020 Vincent Saluzzo. All rights reserved.
//

import Foundation

protocol AlertDelagate: AnyObject {
    func alertMessage(_ message: String)
}
class Calculator {
    weak var delegate: AlertDelagate?
    private func sendToController(message: String) {
        delegate?.alertMessage(message)
    }
    
    var textView = ""
    
    var elements: [String] {
        return textView.split(separator: " ").map { "\($0)" }
    }
    var expressionHaveResult: Bool {
        return textView.firstIndex(of: "=") != nil
    }
    
    func expressionIsCorrect(elements: [String]) -> Bool {
        return elements.last != "+" && elements.last != "-" && elements.last != "x" && elements.last != "/"
    }
    
    func canAddOperator(elements: [String]) -> Bool {
        return elements.last != "+" && elements.last != "-" && elements.last != "x" && elements.last != "/"
    }
    func expressionHaveEnoughElement(elements: [String]) -> Bool {
        return elements.count >= 3
    }
    func expressionDontHaveOpatorFirst(elements: [String]) -> Bool {
        return elements.count >= 1
    }
    
    func tappedAddition() {
        guard expressionDontHaveOpatorFirst(elements: elements) else {
            delegate?.alertMessage("Entrer un nombre !")
            return
        }
        if canAddOperator(elements: elements) {
            textView.append(" + ")
        } else {
            delegate?.alertMessage("Un operateur est déja mis !")
        }
    }
    
    func tappedSubstration() {
        guard expressionDontHaveOpatorFirst(elements: elements) else {
            delegate?.alertMessage("Entrer un nombre !")
            return
        }
        if canAddOperator(elements: elements) {
            textView.append(" - ")
        } else {
            delegate?.alertMessage("Un operateur est déja mis !")
        }
    }
    
    func tappedMultiplication() {
        guard expressionDontHaveOpatorFirst(elements: elements) else {
            delegate?.alertMessage("Entrer un nombre !")
            return
        }
        if canAddOperator(elements: elements) {
            textView.append(" x ")
        } else {
            delegate?.alertMessage("Un operateur est déja mis !")
        }
    }
    
    func tappedDivision() {
        guard expressionDontHaveOpatorFirst(elements: elements) else {
            delegate?.alertMessage("Entrer un nombre !")
            return
        }
        if canAddOperator(elements: elements) {
            textView.append(" / ")
        } else {
            delegate?.alertMessage("Un operateur est déja mis !")
        }
    }
    
    func tappedEqual() {
        guard expressionIsCorrect(elements: elements) else {
            delegate?.alertMessage("Entrez une expression correcte !")
            return
        }
        
        guard expressionHaveEnoughElement(elements: elements) else {
            delegate?.alertMessage("Ajouter votre calcul !")
            return
        }
    }
    
    func division(left: Double, right: Double) -> Double {
        let result = Double(left / right)
        if right == 0 {
            delegate?.alertMessage("Ne peut pas être divisible par 0")
        }
        return result
    }
    
    func equal() {
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
            case "/": result = division(left: left, right: right)
                
            default: delegate?.alertMessage("Demarrez un nouveau calcul")
                return textView.append("")
            }
            for _ in 1...3 {
                operationsToReduce.remove(at: place)
            }
            
            operationsToReduce.insert("\(result)", at: place)
        }
//        textView.append(" = \(operationsToReduce.first!)")

    }
}

