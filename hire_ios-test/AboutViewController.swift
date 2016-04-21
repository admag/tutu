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
    }
}
