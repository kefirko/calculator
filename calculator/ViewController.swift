//
//  ViewController.swift
//  calculator
//
//  Created by Den on 1/25/16.
//  Copyright © 2016 Denys Mykhailenko. All rights reserved.
//

import UIKit
import AVFoundation

class ViewController: UIViewController {
    
    @IBOutlet weak var outputLabel: UILabel!
    
    var btnSound: AVAudioPlayer!
    var displayNumber = ""
    var firstValStr = ""
    var secondVarStr = ""
    var currentOperation: Operation = Operation.Empty
    var result = ""
    
    enum Operation: String {
        case Divide = "/"
        case Multiply = "*"
        case Subtract = "-"
        case Add = "+"
        case Empty = "Empty"
    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let pathBtnSound = NSBundle.mainBundle().pathForResource("btn", ofType: "wav")
        let soundUrl = NSURL(fileURLWithPath: pathBtnSound!)
        do {
            try btnSound = AVAudioPlayer(contentsOfURL: soundUrl)
            } catch let error as NSError {
            print(error.debugDescription)
            }
        }

    @IBAction func numberPressed(btn:UIButton){
        playSound()
        displayNumber += "\(btn.tag)"
        outputLabel.text = displayNumber
    }
    
    @IBAction func onAddPressed(sender: AnyObject) {
        processOperation(Operation.Add)
    }
    
    @IBAction func onMultiplyPressed(sender: AnyObject) {
        processOperation(Operation.Multiply)
    }
    
    @IBAction func onSubtractPressed(sender: AnyObject) {
        processOperation(Operation.Subtract)
    }
    
    @IBAction func onDividePressed(sender: AnyObject) {
        processOperation(Operation.Divide)
    }
    
    @IBAction func onEqualPressed(sender: AnyObject) {
        processOperation(currentOperation)
    }
    
    @IBAction func onDotPressed(sender: AnyObject) {
        
        if displayNumber.containsString(".") {
            playSound()
        } else {
            playSound()
            if displayNumber != "" {
                displayNumber += "."
                outputLabel.text = displayNumber
            } else {
                displayNumber += "0."
                outputLabel.text = displayNumber
            }
        }
        
        
    }
    
    @IBAction func onClearPressed(sender: AnyObject) {
        displayNumber = ""
        firstValStr = ""
        secondVarStr = ""
        currentOperation = Operation.Empty
        outputLabel.text = "0"
    }
    func processOperation (op:Operation){
        playSound()
        if currentOperation != Operation.Empty{
        if displayNumber != "" {
            secondVarStr = displayNumber
            displayNumber = ""
            if currentOperation == Operation.Multiply {
                result = "\(Double(firstValStr)! * Double(secondVarStr)!)"
            } else if currentOperation == Operation.Divide {
                result = "\(Double(firstValStr)! / Double(secondVarStr)!)"
            } else if currentOperation == Operation.Subtract {
                result = "\(Double(firstValStr)! - Double(secondVarStr)!)"
            } else if currentOperation == Operation.Add {
                result = "\(Double(firstValStr)! + Double(secondVarStr)!)"
            }
            
            firstValStr = result
            outputLabel.text = result
            
            }
            currentOperation = op
        } else {
            firstValStr = displayNumber
            displayNumber = ""
            currentOperation = op
        }
    }
    
    func playSound() {
        if btnSound.playing {
            btnSound.stop()
        }
        btnSound.play()
    }
}


