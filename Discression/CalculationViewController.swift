//
//  CalculationViewController.swift
//  Discression
//
//  Created by Wilson Styres on 10/8/17.
//  Copyright © 2017 Wilson Styres. All rights reserved.
//

import Cocoa

class CalculationViewController: NSViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        NotificationCenter.default.addObserver(self, selector: #selector(CalculationViewController.calculationFieldDidChange), name: NSNotification.Name(rawValue: "NSTextDidChangeNotification"), object: nil)
        // Do any additional setup after loading the view.
    }

    override var representedObject: Any? {
        didSet {
        // Update the view, if already loaded.
        }
    }
    
    @objc func calculationFieldDidChange() {
        print("nice!")
    }
    
}

