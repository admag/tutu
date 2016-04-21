//
//  Station.swift
//  hire_ios-test
//
//  Created by Aydarka on 19.04.16.
//  Copyright © 2016 Magafurov Aydar. All rights reserved.
//

import UIKit

class Station: NSObject {
    var name: String
    var city: String
    var country: String
    var region: String
    
    init(name : String, city : String, country : String, region : String) {
        self.name = name
        self.city = city
        self.country = country
        self.region = region
    }
}
