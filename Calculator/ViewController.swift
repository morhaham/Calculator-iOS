//
//  ViewController.swift
//  Calculator
//
//  Created by Mor Haham on 24/03/2017.
//  Copyright © 2017 Mor Haham. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var display: UILabel!
    @IBOutlet weak var dotButton: UIButton!
    var userIsTyping = false
    
    @IBAction func ClearDisplay(_ sender: UIButton) {
        if sender.currentTitle != nil{
            display.text = ""
            displayValue = 0
        }
    }
    
    
    @IBAction func touchDigit(_ sender: UIButton) {
        dotButton.isUserInteractionEnabled = true
        if var digit = sender.currentTitle {
            if digit == "." {
                if display.text!.contains(".") {
                    dotButton.isUserInteractionEnabled = false
                    digit = ""
                }
            }
            if userIsTyping {
                let textCurrentInDisplay = display.text!
                display.text = textCurrentInDisplay + digit
            }
            else {
                display.text = digit
                userIsTyping = true
            }
        }
    }
    
    var displayValue : Double {
        get {
            return Double(display.text!)!
        }
        set {
            display.text = String(newValue)
        }
    }
    
    private var brain = Calc()
    
    @IBAction func touchSymbol(_ sender: UIButton) {
        if userIsTyping {
            brain.setOperand(displayValue)
            userIsTyping = false
        }
        if let symbol = sender.currentTitle {
            brain.performOperation(symbol)
        }
        if let result = brain.result {
            displayValue = result
        }
        
    }
    
    
    
    
}

