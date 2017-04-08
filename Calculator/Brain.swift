//
//  Brain.swift
//  Calculator
//
//  Created by Mor Haham on 27/03/2017.
//  Copyright © 2017 Mor Haham. All rights reserved.
//

import Foundation

func changeSign(operand: Double)->Double {
    return -operand
}

func addition(operand1: Double,operand2: Double)->Double {
   return operand1+operand2
}

func multiply(operand1: Double, operand2: Double)->Double {
    return operand1*operand2
}

func subtraction(operand1: Double, operand2: Double)->Double{
    return operand1-operand2
}

func division(operand1: Double, operand2: Double)->Double{
    return operand1/operand2
}

func mod(operand1: Double, operand2: Double)->Double{
    return operand1.truncatingRemainder(dividingBy: operand2)
}

func powit(operand1: Double, operand2: Double)->Double{
    guard operand2 != 0 else{
        return 1
    }
    var result = operand1, p = operand2
    while p > 1 {
        result *= operand1
        p = p - 1
    }
    return result
}





struct Calc {
    
    private var accumulator: Double?
    var symbolIsAconstant = false
    var resultIsPending = false
    var description = ""
    
    private enum Operation {
        case constant(Double)
        case unaryOperation((Double)->Double)
        case binaryOperation((Double,Double)->Double)
        case equals
    }
    

    
    private var operations: Dictionary<String,Operation> = [
        "π" : Operation.constant(Double.pi),
        "e" : Operation.constant(M_E),
        "√" : Operation.unaryOperation(sqrt),
        "cos" : Operation.unaryOperation(cos),
        "±" : Operation.unaryOperation(changeSign),
        "×" : Operation.binaryOperation(multiply),
        "+" : Operation.binaryOperation(addition),
        "-" : Operation.binaryOperation(subtraction),
        "=" : Operation.equals,
        "÷" : Operation.binaryOperation(division),
        "mod" : Operation.binaryOperation(mod),
        "sin" : Operation.unaryOperation(sin),
        "tan" : Operation.unaryOperation(tan),
        "pow" : Operation.binaryOperation(powit)
    
    ]
    
    mutating func performOperation(_ symbol: String) {
        symbolIsAconstant = false
        if let operation = operations[symbol] {
            switch operation {
            case .constant(let value):
                accumulator = value
                symbolIsAconstant = true
            case .unaryOperation(let function):
                if accumulator != nil {
                    accumulator = function(accumulator!)
                }
            case .binaryOperation(let function):
                if accumulator != nil{
                    pendingBinaryOp = pendingBinaryOperation(function: function, firstOperand: accumulator!)
                    accumulator = nil
                }
            case .equals:
                performPendingBinaryOperation()
            }
        }
        
        
    }
    
    
    
    private mutating func performPendingBinaryOperation(){
        if pendingBinaryOp != nil && accumulator != nil{
            accumulator = pendingBinaryOp!.perform(with: accumulator!)
            pendingBinaryOp = nil
        }
    }
    
    private var pendingBinaryOp: pendingBinaryOperation?
    
    private struct pendingBinaryOperation {
        let function : (Double,Double) -> Double
        let firstOperand : Double
        
        func perform(with secondOperand: Double) -> Double {
            return function(firstOperand,secondOperand)
        }
    }
    
    mutating func setOperand(_ operand: Double)  {
        accumulator = operand
    }
    
    var result: Double? {
        get {
            return accumulator
        }
        
    }
    
    
}
