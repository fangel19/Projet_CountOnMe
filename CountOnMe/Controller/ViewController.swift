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
    
    //    var elements: [String] {
    //        return textView.text.split(separator: " ").map { "\($0)" }
    //    }
    
    //    var expressionHaveResult: Bool {
    //        return textView.text.firstIndex(of: "=") != nil
    //    }
    
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
        
        if calculator.expressionHaveResult {
            textView.text = ""
        }
        
        textView.text.append(numberText)
    }
    
    // MARK: - Operator
    
    @IBAction func tappedAdditionButton(_ sender: UIButton) {
        calculator.tappedAddition()
    }
    
    @IBAction func tappedSubstractionButton(_ sender: UIButton) {
        calculator.tappedSubstration()
    }
    
    @IBAction func tappedMultiplicationButton(_ sender: UIButton) {
        calculator.tappedMultiplication()
    }
    
    @IBAction func tappedDivisionButton(_ sender: UIButton) {
        calculator.tappedDivision()
    }
    
    @IBAction func tappedAcButton(_ sender: UIButton) {
        textView.text = ""
    }
    
    @IBAction func tappedEqualButton(_ sender: UIButton) {
        calculator.tappedEqual()
        calculator.equal()
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
