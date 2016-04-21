//
//  AboutViewController.swift
//  hire_ios-test
//
//  Created by Aydarka on 20.04.16.
//  Copyright © 2016 Magafurov Aydar. All rights reserved.
//

import UIKit

class AboutViewController: UIViewController {

    @IBOutlet weak var copyrightLabel: UILabel!
    @IBOutlet weak var versionLabel: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        copyrightLabel.text = "Magafurov Aydar ©. All rights reserved."
        versionLabel.text = "Версия 1.0"
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
