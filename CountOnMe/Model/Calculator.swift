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
    func division(left: Double, right: Double) -> Double {
        let result = Double(left / right)
        if right == 0 {
            delegate?.alertMessage("Ne peut pas être divisible par 0")
        }
        return result
    }
    func equal() {
        
    }
}

