//
//  ViewController.swift
//  tips
//
//  Created by Keenahn Jung on 6/15/15.
//  Copyright (c) 2015 Keenahn Jung. All rights reserved.
///var/www/vhosts/sandbox/xcodeprojs/tips/tips/ViewController.swift

import UIKit

class ViewController: UIViewController {
    
    var defaults = NSUserDefaults.standardUserDefaults()
    
    let initial_percent_0: Double = 0.15
    let initial_percent_1: Double = 0.18
    let initial_percent_2: Double = 0.2
    
    var percent_0: Double = 0.0
    var percent_1: Double = 0.0
    var percent_2: Double = 0.0
    var default_percent_position: Int = 0
    var tipPercents: Array<Double> = [0, 0, 0]
    
    @IBOutlet weak var billField: UITextField!
    @IBOutlet weak var tipLabel: UILabel!
    @IBOutlet weak var totalLabel: UILabel!
    @IBOutlet weak var tipControl: UISegmentedControl!
    @IBOutlet weak var outputView: UIView!
    
    @IBOutlet weak var twoPeopleLabel: UILabel!
    @IBOutlet weak var threePeopleLabel: UILabel!
    @IBOutlet weak var fourPeopleLabel: UILabel!
    
    @IBOutlet weak var twoPeopleTotalLabel: UILabel!
    @IBOutlet weak var threePeopleTotalLabel: UILabel!
    @IBOutlet weak var fourPeopelTotalLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        tipLabel.text = "$0.00"
        totalLabel.text = "$0.00"

        // Get user settings
        defaults = NSUserDefaults.standardUserDefaults() // Set default values if user settings are not set

        default_percent_position = defaults.integerForKey("default_percent_position") ?? 0
        
        tipControl.selectedSegmentIndex = default_percent_position
        
        // billField.becomeFirstResponder()

        self.outputView.alpha = 0
        
        let happyFace = "\u{263A}\u{FE0E}"
    
        twoPeopleLabel.text = happyFace + happyFace
        threePeopleLabel.text = happyFace + happyFace + happyFace
        fourPeopleLabel.text = happyFace + happyFace + happyFace + happyFace
        
        
    }

    
    @IBAction func onEditingBegin(sender: AnyObject) {
        if billField.text == "$" {
            billField.text = nil

            UIView.animateWithDuration(0.5, animations: {
                self.outputView.alpha = 1.0
                self.billField.center.y -= 190
            })
            
            
        }
        //UIView.animateWithDuration(0.5, delay: 0.3, options: nil, animations: {
        //    self.username.center.x += self.view.bounds.width
        //}, completion: nil)
    }

    @IBAction func onEditingEnd(sender: AnyObject) {
        if billField.text.isEmpty {
            billField.text = "$"
            UIView.animateWithDuration(0.5, animations: {
                self.outputView.alpha = 0
            })
        
        }
        
    }
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        percent_0 = defaults.doubleForKey("percent_0") > 0 ? defaults.doubleForKey("percent_0") : initial_percent_0
        percent_1 = defaults.doubleForKey("percent_1") > 0 ? defaults.doubleForKey("percent_1") : initial_percent_1
        percent_2 = defaults.doubleForKey("percent_2") > 0 ? defaults.doubleForKey("percent_2") : initial_percent_2
        tipPercents = [percent_0, percent_1, percent_2]
        
        updateSegementedControls()

        updateTip()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func onEditingChanged(sender: AnyObject) {
        updateTip()
        // println(NSString(format:"%.2f", billAmount))
    }

    @IBAction func onTap(sender: AnyObject) {
        view.endEditing(true)
    }
    
    func updateTip(){
        var billAmount = 0.0
        var tip = 0.0
        
        var tipPercent = tipPercents[tipControl.selectedSegmentIndex]
        var total = 0.0
        if let value = billField?.text {
            billAmount = (value as NSString).doubleValue
        }
        tip = billAmount * tipPercent
        total = billAmount + tip
        
        tipLabel.text = String(format:"$%.2f", tip)
        totalLabel.text = String(format:"$%.2f", total)
        twoPeopleTotalLabel.text = String(format:"$%.2f", total/2.0)
        threePeopleTotalLabel.text = String(format:"$%.2f", total/3.0)
        fourPeopelTotalLabel.text = String(format:"$%.2f", total/4.0)
        
    }

    func setPercent0(val: Double){
        percent_0 = val
        updateSegementedControls()
    }
    
    func setPercent1(val: Double){
        percent_1 = val
        updateSegementedControls()
    }
    
    func setPercent2(val: Double){
        percent_2 = val
        updateSegementedControls()
    }
    
    func updateSegementedControls(){
        var tipPercentStrings = [
            String(format:"%.0f%%", percent_0 * 100),
            String(format:"%.0f%%", percent_1 * 100),
            String(format:"%.0f%%", percent_2 * 100)
        ]
        
        for var i = 0; i < 3; i++ {
            tipControl.setTitle(tipPercentStrings[i], forSegmentAtIndex: i)
        }
    }
    
    
}

