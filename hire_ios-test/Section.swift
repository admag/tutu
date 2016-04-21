//
//  Section.swift
//  hire_ios-test
//
//  Created by Aydarka on 20.04.16.
//  Copyright © 2016 Magafurov Aydar. All rights reserved.
//

import UIKit

class Section: NSObject {

    var heading: String
    var items: [Station]
    
    init(city: String, country: String, items: [Station]) {
        self.heading = city + ", " + country
        self.items = items
    }
}
