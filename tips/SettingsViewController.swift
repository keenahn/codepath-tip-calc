//
//  ViewController.swift
//  tips
//
//  Created by Keenahn Jung on 6/15/15.
//  Copyright (c) 2015 Keenahn Jung. All rights reserved.
///var/www/vhosts/sandbox/xcodeprojs/tips/tips/ViewController.swift

import UIKit

class SettingsViewController: UIViewController {
    
    // TODO: DRY EVERYTHING
    let initial_percent_0: Double = 0.15
    let initial_percent_1: Double = 0.18
    let initial_percent_2: Double = 0.2

    var default_percent_position: Int = 0
    var tipPercents: Array<Double> = [0, 0, 0]
    
    var defaults = NSUserDefaults.standardUserDefaults()
    
    @IBOutlet weak var defaultPercentControl: UISegmentedControl!
    @IBOutlet weak var percentInput0: UITextField!
    @IBOutlet weak var percentInput1: UITextField!
    @IBOutlet weak var percentInput2: UITextField!
    
    // TODO: DRY with main ViewController
    var percent_0: Double = 0.0
    var percent_1: Double = 0.0
    var percent_2: Double = 0.0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Get user settings
        defaults = NSUserDefaults.standardUserDefaults()
        
        // Set default values if user settings are not set
        percent_0 = defaults.doubleForKey("percent_0") > 0 ? defaults.doubleForKey("percent_0") : initial_percent_0
        percent_1 = defaults.doubleForKey("percent_1") > 0 ? defaults.doubleForKey("percent_1") : initial_percent_1
        percent_2 = defaults.doubleForKey("percent_2") > 0 ? defaults.doubleForKey("percent_2") : initial_percent_2
        default_percent_position = defaults.integerForKey("default_percent_position") ?? 0
        
        tipPercents = [percent_0, percent_1, percent_2]
        
        updateSegementedControls()
        
        defaultPercentControl.selectedSegmentIndex = default_percent_position
        
        percentInput0.text = String(format:"%.0f%", percent_0 * 100)
        percentInput1.text = String(format:"%.0f%", percent_1 * 100)
        percentInput2.text = String(format:"%.0f%", percent_2 * 100)
    }
    
    
    // TODO: DRY with main ViewController
    func updateSegementedControls(){
        var tipPercentStrings = [
            String(format:"%.0f%%", percent_0 * 100),
            String(format:"%.0f%%", percent_1 * 100),
            String(format:"%.0f%%", percent_2 * 100)
        ]
        
        for var i = 0; i < 3; i++ {
            defaultPercentControl.setTitle(tipPercentStrings[i], forSegmentAtIndex: i)
        }
    }
    
    
    @IBAction func dismissSettings(sender: AnyObject) {
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    @IBAction func defaultPercentChanged(sender: AnyObject) {
        defaults.setInteger(defaultPercentControl.selectedSegmentIndex, forKey: "default_percent_position")
        defaults.synchronize()    
    }
    
    // TODO: DRY
    @IBAction func percentInput0Changed(sender: AnyObject) {
        if let value = percentInput0?.text {
            percent_0 = (value as NSString).doubleValue / 100.0
        }
        defaults.setDouble(percent_0, forKey: "percent_0")
        defaults.synchronize()
        updateSegementedControls()
    }
    @IBAction func percentInput1Changed(sender: AnyObject) {
        if let value = percentInput1?.text {
            percent_1 = (value as NSString).doubleValue  / 100.0
        }
        defaults.setDouble(percent_1, forKey: "percent_1")
        defaults.synchronize()
        updateSegementedControls()
    }
    @IBAction func percentInput2Changed(sender: AnyObject) {
        if let value = percentInput2?.text {
            percent_2 = (value as NSString).doubleValue  / 100.0
        }
        defaults.setDouble(percent_2, forKey: "percent_2")
        defaults.synchronize()
        updateSegementedControls()
    }
    @IBAction func onTap(sender: AnyObject) {
        view.endEditing(true)
    }


}
