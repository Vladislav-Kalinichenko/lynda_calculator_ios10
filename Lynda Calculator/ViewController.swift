//
//  ViewController.swift
//  Lynda Calculator
//
//  Created by John Doe on 3/10/17.
//  Copyright © 2017 John Doe. All rights reserved.
//

import UIKit

enum modes {
    case not_set
    case addition
    case subtration
}


class ViewController: UIViewController {
    @IBOutlet weak var label: UILabel!
    
    var labelString:String = "0"
    var currentMode:modes = .not_set
    var savedNum:Int = 0
    var lastButtonWasMode:Bool = false
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    @IBAction func didPressPlus(_ sender: Any) {
        changeMode(newMode: .addition)
    }
    @IBAction func didPressSubtract(_ sender: Any) {
        changeMode(newMode: .subtration)
    }
    @IBAction func didPressEquals(_ sender: Any) {
        guard let labelInt:Int = Int(labelString) else {
            return
        }
        if (currentMode == .not_set || lastButtonWasMode){
            return
        }
        if (currentMode == .addition){
            savedNum += labelInt
        } else if (currentMode == .subtration) {
            savedNum -= labelInt
        }
        currentMode = .not_set
        labelString = "\(savedNum)"
        updateText()
        lastButtonWasMode = true
    }
    @IBAction func didPressClear(_ sender: Any) {
        labelString = "0"
        currentMode = .not_set
        savedNum = 0
        lastButtonWasMode = false
        label.text = "0"
    }
    @IBAction func didPressNumber(_ sender: UIButton) {
        let stringValue:String? = sender.titleLabel?.text
        
        if (lastButtonWasMode){
            lastButtonWasMode = false
            labelString = "0"
        }
        
        labelString = labelString.appending(stringValue!)
        updateText()
    }
    
    func updateText(){
        guard let labelInt:Int = Int(labelString) else {
            return
        }
        if (currentMode == .not_set){
            savedNum = labelInt
        }
        
        label.text = "\(labelInt)"
    }
    
    func changeMode(newMode: modes){
        if (savedNum == 0){
            return
        }
        currentMode = newMode
        lastButtonWasMode = true
    }
    
}

