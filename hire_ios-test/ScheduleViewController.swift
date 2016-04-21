
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
    var filteredStations = [Station] ()
    var sections = [Section]()
    var stationToPass: Station?
    var postValue: String?
    var flag = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        searchController.searchResultsUpdater = self
        searchController.dimsBackgroundDuringPresentation = false
        definesPresentationContext = true
        tableItems.tableHeaderView = searchController.searchBar
        
        //спарсить json
        if self.postValue == "from" {
            navigationTitle.title = "Станция отправления"
            sections = parseSections().getSectionsFrom()
            flag = true
        } else {
            navigationTitle.title = "Станция назначения"
            sections = parseSections().getSectionsTo()
            flag = false
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
        var cell = tableItems.dequeueReusableCellWithIdentifier("ScheduleItemCell") as! ScheduleItemCell
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
        //выделили ячейку  
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
        for stat in sections {
            var array = stat.items.filter {
                s in return s.name.lowercaseString.containsString(searchText.lowercaseString)
            }
            filteredStations.appendContentsOf(array)
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
            //searchController.active = false
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
