//
//  CalculationViewController.swift
//  Discression
//
//  Created by Wilson Styres on 10/8/17.
//  Copyright © 2017 Wilson Styres. All rights reserved.
//

import Cocoa

class CalculationViewController: NSViewController {

    @IBOutlet weak var textField: NSTextField!
    @IBOutlet weak var resultTextField: NSTextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        recalculateFields(value: "")
        NotificationCenter.default.addObserver(self, selector: #selector(CalculationViewController.calculationFieldDidChange), name: NSNotification.Name(rawValue: "NSTextDidChangeNotification"), object: nil)
        // Do any additional setup after loading the view.
    }

    override var representedObject: Any? {
        didSet {
        // Update the view, if already loaded.
        }
    }
    
    @objc func calculationFieldDidChange() {
        recalculateFields(value: textField.stringValue)
    }
    
    func recalculateFields(value: String) {
        let result: Result = Calculator.calculateAll(number: value)
        
        let answerString: String = "Hex to Int: \(result.hexToInt)\nHex to Double: \(result.hexToDouble)\nHex to Binary: \(result.decimalToHex)\nDecimal to Hex: \(result.decimalToHex)\nDecimal to Binary: \(result.decimalToBinary)\nBinary to Int: \(result.binaryToInt)\nBinary to Double: \(result.binaryToDouble)\nBinary to Hex: \(result.binaryToHex)\nTwo's Complement to Int: \(result.complementToInt)"
        
        resultTextField.stringValue = answerString
    }
    
}

