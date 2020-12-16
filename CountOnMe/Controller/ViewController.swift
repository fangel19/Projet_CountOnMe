//
//  ViewController.swift
//  SimpleCalc
//
//  Created by Vincent Saluzzo on 29/03/2019.
//  Copyright © 2019 Vincent Saluzzo. All rights reserved.
//
import UIKit

class ViewController: UIViewController {
    
    // MARK: - Outlet and var
    
    @IBOutlet weak var textView: UITextView!
    @IBOutlet var numberButtons: [UIButton]!
    
    var calculator = Calculator()
    
    // MARK: - viewDidLoad
    
    override func viewDidLoad() {
        super.viewDidLoad()
        calculator.delegate = self
    }
    
    // MARK: - Action Number Button
    
    @IBAction func tappedNumberButton(_ sender: UIButton) {
        guard let numberText = sender.title(for: .normal) else {
            return
        }
        calculator.addStringNumber(stringNumber: numberText)
    }
    
    // MARK: - Actions Operator
    
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
        calculator.textView = ""
    }
    
    @IBAction func tappedEqualButton(_ sender: UIButton) {
        calculator.tappedEqual()
        //        calculator.equal()
    }
}

// MARK: - Extension
// Display error message
extension ViewController: AlertDelagate {
    func alertMessage(_ message: String) {
        let alertVC = UIAlertController(title: "Erreur!", message: message, preferredStyle: .alert)
        alertVC.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
        return self.present(alertVC, animated: true, completion: nil)
    }
    //    Display text on calculator
    func didReceiveData(_ data: String) {
        textView.text = calculator.textView
    }
}
