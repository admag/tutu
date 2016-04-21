//
//  ChoiceViewController.swift
//  hire_ios-test
//
//  Created by Aydarka on 20.04.16.
//  Copyright © 2016 Magafurov Aydar. All rights reserved.
//

import UIKit

class ChoiceViewController: UIViewController , UITextFieldDelegate{

    @IBOutlet weak var fromText: UITextField!
    @IBOutlet weak var toText: UITextField!
    
    
    override func viewDidLoad() {
        
        super.viewDidLoad()

        fromText.delegate = self
        toText.delegate = self
        
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func textFieldShouldBeginEditing(textField: UITextField) -> Bool {
        return false
    }
    
    @IBAction func saveChosenValue (segue: UIStoryboardSegue) {
        if let scheduleViewController = segue.sourceViewController as? ScheduleViewController {
            if let stationToWrite = scheduleViewController.stationToPass {
                if scheduleViewController.flag {
                    fromText.text = stationToWrite.name
                } else  {
                    toText.text = stationToWrite.name
                }
            }
        }
    }
    
    @IBAction func pressFrom(sender: AnyObject) {
        performSegueWithIdentifier("choiceToSchedule", sender: "from")
        
    }

    @IBAction func pressTo(sender: AnyObject) {
        performSegueWithIdentifier("choiceToSchedule", sender: "to")
    }
    
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "choiceToSchedule" {
            if let navcontroller = segue.destinationViewController as? UINavigationController {
                if let controller = navcontroller.topViewController as? ScheduleViewController {
                    if let send = sender as? String {
                        controller.postValue = send
                    }
                }
            }
        }
    }
}
