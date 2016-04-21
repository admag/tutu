
//
//  ScheduleViewController.swift
//  hire_ios-test
//
//  Created by Aydarka on 19.04.16.
//  Copyright © 2016 Magafurov Aydar. All rights reserved.
//


import UIKit

class ScheduleViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var navigationTitle: UINavigationItem!
    @IBOutlet weak var tableItems: UITableView!
   
    var searchController = UISearchController(searchResultsController: nil)
    //станции для отображения при поиске
    var filteredStations = [Station] ()
    var sections = [Section]()
    //для unwind segue - при клике (выборе) станции
    var stationToPass: Station?
    //из предшествующего контроллера, для определения для каких станции контролер (отправления или прибытия)
    var postValue: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        searchController.searchResultsUpdater = self
        searchController.dimsBackgroundDuringPresentation = false
        definesPresentationContext = true
        tableItems.tableHeaderView = searchController.searchBar
        
        //тянем модель
        if self.postValue == "from" {
            navigationTitle.title = "Станция отправления"
            sections = parseSections().getSectionsFrom()
        } else {
            navigationTitle.title = "Станция назначения"
            sections = parseSections().getSectionsTo()
        }
        
        tableItems.delegate = self
        tableItems.dataSource = self
        tableItems.tableFooterView = UIView()
        
    }
    
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        if searchController.active && searchController.searchBar.text! != "" {
            return 1
        }
        return sections.count
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if searchController.active && searchController.searchBar.text! != "" {
            return filteredStations.count
        }
        return sections[section].items.count
    }
    
    func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if searchController.active && searchController.searchBar.text! != "" {
            return "Результаты поиска"
        }
        return sections[section].heading
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableItems.dequeueReusableCellWithIdentifier("ScheduleItemCell") as! ScheduleItemCell
        var item: Station
        if searchController.active && searchController.searchBar.text! != "" {
            item = filteredStations[indexPath.row]
        } else {
            item  = sections[indexPath.section].items[indexPath.row]
        }
        cell.labelName.text = item.name
        return cell
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        var item: Station
        if searchController.active && searchController.searchBar.text! != "" {
            item = filteredStations[indexPath.row]
            
        } else {
            item = sections[indexPath.section].items[indexPath.row]
            
        }
        self.performSegueWithIdentifier("saveChosenValue", sender: item)
    }
    
    func tableView(tableView: UITableView, accessoryButtonTappedForRowWithIndexPath indexPath: NSIndexPath) {
        //выделение i
        var item: Station
        if searchController.active && searchController.searchBar.text! != "" {
            item = filteredStations[indexPath.row]
            //searchController.active = false
        } else {
            item = sections[indexPath.section].items[indexPath.row]
        }
        //searchController.dismissViewControllerAnimated(false, completion: nil)
        self.performSegueWithIdentifier("scheduleToItem", sender: item)
    }
    
    @IBAction func cancel(sender: UIBarButtonItem) {
        searchController.dismissViewControllerAnimated(true, completion: nil)
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    func filterContentForSearchText(searchText: String, scope: String = "All") {
        filteredStations = [Station] ()
        for stationsInSection in sections {
            let stations = stationsInSection.items.filter {
                station in return station.name.lowercaseString.containsString(searchText.lowercaseString)
            }
            filteredStations.appendContentsOf(stations)
        }
        tableItems.reloadData()
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if let controller = segue.destinationViewController as? ScheduleDetailsViewController {
            if let send = sender as? Station {
                controller.title = send.name
                controller.postValue = send
            }
        } else {
            if segue.identifier == "saveChosenValue" {
                stationToPass = sender as? Station
            }
        }
        
    }
}

extension ScheduleViewController: UISearchResultsUpdating {
    func updateSearchResultsForSearchController(searchController: UISearchController) {
        filterContentForSearchText(searchController.searchBar.text!)
    }
}
