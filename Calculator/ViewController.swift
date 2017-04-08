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
    @IBOutlet weak var currentDisplay: UILabel!
    var userIsTyping = false
    

    @IBAction func clearDisplay(_ sender: UIButton) {
        if sender.currentTitle != nil{
            displayValue = 0
            display.text = String(displayValue)
            currentDisplay.text! = ""
            
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
                currentDisplay.text! = currentDisplay.text! + digit
            }
            else {
                display.text = digit
                currentDisplay.text! = currentDisplay.text! + digit
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
    let numbers: CharacterSet = ["0","1","2","3","4","5","6","7","8","9"]
    
    @IBAction func touchSymbol(_ sender: UIButton) {
        if userIsTyping {
            brain.setOperand(displayValue)
            userIsTyping = false
        }
        if let symbol = sender.currentTitle {
            if currentDisplay.text!.contains(symbol) || currentDisplay.text!.contains("=") || currentDisplay.text!.rangeOfCharacter(from: numbers) == nil {
                currentDisplay.text!.remove(at: currentDisplay.text!.index(before: currentDisplay.text!.endIndex))
            }
            if currentDisplay.text! == "" {
                currentDisplay.text! = ""
            }
            currentDisplay.text! = currentDisplay.text! + symbol
            brain.performOperation(symbol)
            
            if let result = brain.result {
                if displayValue != 0 && brain.symbolIsAconstant == false {
                    displayValue = result
                }
                else if brain.symbolIsAconstant == true {
                    displayValue = result
                }
                else{
                    return
                }
                displayValue = result
                
            }
            
        }
    }
    
    
    
    
}

