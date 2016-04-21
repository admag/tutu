//
//  ScheduleDetailsViewController.swift
//  hire_ios-test
//
//  Created by Aydarka on 19.04.16.
//  Copyright © 2016 Magafurov Aydar. All rights reserved.
//

import UIKit

class ScheduleDetailsViewController: UIViewController {


    @IBOutlet weak var stationName: UILabel!
    @IBOutlet weak var stationCity: UILabel!
    @IBOutlet weak var stationRegion: UILabel!
    @IBOutlet weak var stationCountry: UILabel!
    
    
    var postValue: Station?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        stationName.text = self.postValue?.name
        if (self.postValue?.city == "") {
            stationCity.text = "Информация отсутсвует"
        } else {
            stationCity.text = self.postValue?.city
        }
        if (self.postValue?.region == "") {
            stationRegion.text = "Информация отсутсвует"
        } else {
            stationRegion.text = self.postValue?.region
        }
        if (self.postValue?.country == "") {
            stationCountry.text = "Информация отсутсвует"
        } else {
            stationCountry.text = self.postValue?.country
        }
    }
}
