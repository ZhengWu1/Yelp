//
//  RestaurantViewController.swift
//  Yelp
//
//  Created by Zheng Wu on 4/17/15.
//  Copyright (c) 2015 Zheng Wu. All rights reserved.
//

import UIKit

class RestaurantViewController: UIViewController, FiltersViewControllerDelegate,  UITableViewDataSource, UITableViewDelegate, UISearchBarDelegate, UISearchDisplayDelegate {
    var client: YelpClient!
    @IBOutlet weak var tableView: UITableView!
    
    var businesses: NSArray!
    var searchBar: UISearchBar!
    var filteredBusinesses: NSArray!
    var isSearching: Bool!
    
    let yelpConsumerKey = "7qSHNyMrZGeSWz8ituzqGA"
    let yelpConsumerSecret = "yBCeGO24kzYw-CFriJD8bloLym4"
    let yelpToken = "XyBzS7IOzXk1ASbfD9MoDAi4GaDGtVUW"
    let yelpTokenSecret = "7zXx7VdyMyVhdmP5emsUrOau_1I"
    
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.isSearching = false
        self.tableView.rowHeight = UITableViewAutomaticDimension
        self.tableView.estimatedRowHeight = 85
        
        self.title = "Yelp"
        self.searchBar = UISearchBar(frame: CGRectZero)
        self.searchBar.delegate = self
        
        self.navigationItem.titleView = self.searchBar
        self.navigationItem.titleView?.autoresizingMask = UIViewAutoresizing.FlexibleWidth
        
        
        
        
         client = YelpClient(consumerKey: yelpConsumerKey, consumerSecret: yelpConsumerSecret, accessToken: yelpToken, accessSecret: yelpTokenSecret)
        
//
        var myParams: NSDictionary = NSDictionary()
        self.fetchBusinessesWithQuery("Restaurants", params: myParams)
    }

    func fetchBusinessesWithQuery(query: NSString, params: NSDictionary) {
        
        
        client.searchWithTerm(query, params: params, success: { (operation: AFHTTPRequestOperation!, response: AnyObject!) -> Void in
            var businessDictionaries: NSArray = response["businesses"] as NSArray
            
            self.businesses = Business.businessesWithDictionaries(businessDictionaries)
            
            self.tableView.reloadData()
            
            //println(response)
            }) { (operation: AFHTTPRequestOperation!, error: NSError!) -> Void in
                println(error)
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
         if isSearching == true {
            return self.filteredBusinesses.count
         } else {
            if let array = self.businesses {
                return self.businesses.count
            }
            else {
                return 0
            }
        }
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        var cell:RestaurantCell = tableView.dequeueReusableCellWithIdentifier("RestaurantCell") as RestaurantCell
        
        if isSearching == true {
            cell.setBusiness(self.filteredBusinesses[indexPath.row] as Business)
        } else {
            cell.setBusiness(self.businesses[indexPath.row] as Business)
        }
        return cell
    }
    
    func filtersViewController(filtersViewController: FiltersViewController, didChangeFilters filters: NSDictionary) {
        self.fetchBusinessesWithQuery("Restaurants", params: filters)
    }
    
    func filterContentForSearchText(searchText: String) {
        self.filteredBusinesses = (self.businesses as Array).filter({( business: Business) -> Bool in
            let lowerString = business.name?.lowercaseString
            let lowerSearchText = searchText.lowercaseString
            let stringMatch = lowerString!.rangeOfString(lowerSearchText)
            return (stringMatch != nil)
        })
        println(self.filteredBusinesses)
    }
    
    func searchBar(searchBar: UISearchBar, textDidChange searchText: String) {
        if searchBar.text.isEmpty {
            isSearching = false
            tableView.reloadData()
        } else {
            println("search text: %@", searchBar.text as NSString)
            isSearching = true
            self.filterContentForSearchText(searchBar.text)
            tableView.reloadData()
        }
    }
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        if segue.identifier == "PresentFilters" {
            let filtersNC = segue.destinationViewController as UINavigationController
            let filtersVC = filtersNC.viewControllers[0] as FiltersViewController
            filtersVC.delegate = self
        }
    }
    

}
