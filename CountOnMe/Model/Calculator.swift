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
    func didReceiveData(_ data: String)
}
class Calculator {
    weak var delegate: AlertDelagate?
    private func sendToController(message: String) {
        delegate?.alertMessage(message)
    }
    
    private func sendDataToController(data: String) {
        delegate?.didReceiveData(data)
    }
    var textView = ""
    
    var elements: [String] {
        return textView.split(separator: " ").map { "\($0)" }
    }

    private func expressionHaveResult(expression: String) -> Bool {
        return expression.firstIndex(of: "=") != nil
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
    
    func addStringNumber(stringNumber: String) {
        if expressionHaveResult(expression: textView) {
            textView = ""
        }
        textView += stringNumber
        sendDataToController(data: stringNumber)
    }
    
    func tappedAddition() {
        guard expressionDontHaveOpatorFirst(elements: elements) else {
            delegate?.alertMessage("Entrer un nombre !")
            return
        }
        if canAddOperator(elements: elements) {
            textView += " + "
        } else {
            delegate?.alertMessage("Un operateur est déja mis !")
        }
        return sendDataToController(data: "+")
    }
    
    func tappedSubstration() {
        guard expressionDontHaveOpatorFirst(elements: elements) else {
            delegate?.alertMessage("Entrer un nombre !")
            return
        }
        if canAddOperator(elements: elements) {
            textView += " - "
        } else {
            delegate?.alertMessage("Un operateur est déja mis !")
        }
        return sendDataToController(data: "-")
    }
    
    func tappedMultiplication() {
        guard expressionDontHaveOpatorFirst(elements: elements) else {
            delegate?.alertMessage("Entrer un nombre !")
            return
        }
        if canAddOperator(elements: elements) {
            textView += " x "
        } else {
            delegate?.alertMessage("Un operateur est déja mis !")
        }
        return sendDataToController(data: "x")
    }
    
    func tappedDivision() {
        guard expressionDontHaveOpatorFirst(elements: elements) else {
            delegate?.alertMessage("Entrer un nombre !")
            return
        }
        if canAddOperator(elements: elements) {
            textView += " / "
        } else {
            delegate?.alertMessage("Un operateur est déja mis !")
        }
        return sendDataToController(data: "/")
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
        equal()
    }
    
    func division(left: Double, right: Double) -> Double {
        let result = Double(left / right)
        if right == 0 {
            delegate?.alertMessage("Ne peut pas être divisible par 0")
        }
        return result
    }
    
    func checkRightTab(place: Int, right: Int, array: [Any]) -> Bool {
        if (place + right) >= array.count {
            print("count array", array.count, "place + right", place + right)
            delegate?.alertMessage("entrer un nombre")
            return true
        } else {
            
            return false
        }
    }
    
    func equal() {
        
        var operationsToReduce = elements
        while operationsToReduce.count > 1 {
            var place = 0
            if let index = operationsToReduce.firstIndex(where: { $0 == "x" || $0 == "/"}) {
                place = index - 1
            }
            guard let left = Double(operationsToReduce[place]) else { return }
            
            let operand = operationsToReduce[place + 1]
            
            if checkRightTab(place: place, right: 2, array: operationsToReduce) {
                print("casse")
                return
            }
                guard let right = Double(operationsToReduce[place + 2]) else { return }
                
                
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
        
        textView += " = \(operationsToReduce.first ?? "= Error")"
        sendDataToController(data: textView)
        
    }
}

