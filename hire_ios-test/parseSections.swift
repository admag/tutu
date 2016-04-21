//
//  parseSections.swift
//  hire_ios-test
//
//  Created by Aydarka on 20.04.16.
//  Copyright © 2016 Magafurov Aydar. All rights reserved.
//

import UIKit

class parseSections: NSObject {
    
    func getSectionsTo() -> [Section] {
        var result = [Section]()
        
        let url = NSBundle.mainBundle().URLForResource("allStations", withExtension: "json")
        let data = NSData(contentsOfURL: url!)
        
        do {
            let object = try NSJSONSerialization.JSONObjectWithData(data!, options: .MutableContainers)
            if let dict = object as? [String: AnyObject] {
                let citiesTo : NSArray = dict["citiesTo"] as! [[String:NSObject]]
                for stationParsing in citiesTo {
                    let temp = stationParsing["stations"] as! [[String:NSObject]]
                    var stations:[Station] = []
                    for singleStation in temp {
                        let instanceOfStation = Station(name: singleStation["stationTitle"] as! String, city: singleStation["cityTitle"] as! String, country: singleStation["countryTitle"] as! String, region: singleStation["regionTitle"] as! String)
                        stations.append(instanceOfStation)
                    }
                    if let statToSection = stations.first {
                        let section = Section(city: statToSection.city, country: statToSection.country, items: stations)
                        result.append(section)
                    }
                }
            }
        } catch {
            
        }

        return result
    }
    
    //MARK: blabla
    
    func getSectionsFrom() -> [Section] {
        var result = [Section]()
        
        let url = NSBundle.mainBundle().URLForResource("allStations", withExtension: "json")
        let data = NSData(contentsOfURL: url!)
        
        do {
            let object = try NSJSONSerialization.JSONObjectWithData(data!, options: .MutableContainers)
            if let dict = object as? [String: AnyObject] {
                let citiesTo : NSArray = dict["citiesFrom"] as! [[String:NSObject]]
                for stationParsing in citiesTo {
                    let temp = stationParsing["stations"] as! [[String:NSObject]]
                    var stations:[Station] = []
                    for singleStation in temp {
                        let instanceOfStation = Station(name: singleStation["stationTitle"] as! String, city: singleStation["cityTitle"] as! String, country: singleStation["countryTitle"] as! String, region: singleStation["regionTitle"] as! String)
                        stations.append(instanceOfStation)
                    }
                    let statToSection = stations[0]
                    let section = Section(city: statToSection.city, country: statToSection.country, items: stations)
                    result.append(section)
                }
            }
        } catch {
            
        }
        
        return result
    }

}
