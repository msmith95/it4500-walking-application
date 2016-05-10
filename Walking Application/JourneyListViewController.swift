//
//  JourneyListViewController.swift
//  Walking Application
//
//  Created by Seth vonSeggern on 4/23/16.
//  Copyright © 2016 Walking Team A. All rights reserved.
//

import UIKit
import CoreData

class JourneyListViewController: UITableViewController {
    let journeyCollection = DataPassing.sharedInstance
    var filteredJourneys: [Journey]!
    var journey: NSManagedObject?

    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        self.title = "Journey List"
        self.view.backgroundColor = UIColor(red: 0.07, green:0.94, blue:0.63, alpha:1.0)
        
        filteredJourneys = journeyCollection.journeys
        print(journeyCollection.journeys.count)

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        //return filteredJourneys.count
        return journeyCollection.journeys.count
    }

    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("cell", forIndexPath: indexPath) as! JourneyListTableViewCell
        
        
        let journey = filteredJourneys[indexPath.row]
        cell.journeyName.text = journey.journeyName
        cell.journeyDistance.text = String(journey.distance) + " miles"
        print(journey.distance)
        
        cell.accessoryType = .DisclosureIndicator//enum
        
        cell.backgroundColor = UIColor(red: 0.05, green: 0.71, blue: 0.93, alpha: 1)
        

        return cell
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        self.performSegueWithIdentifier("journeySegue", sender: self)
    }
    

    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {

        let controller:JourneyViewController = segue.destinationViewController as! JourneyViewController
        
        if let row = self.tableView.indexPathForSelectedRow?.row {
            controller.journey = filteredJourneys[row]
        }
    }
    @IBAction func getJourneyInProgressData(sender: AnyObject) {
        let journey = DataPasser()
        let object = journey.getJourneyInProgress()
        
        if let object = object{
            print(object.valueForKey("steps"))
            print(object.valueForKey("journeyID"))
            print(object.valueForKey("startDate"))
            print(object.valueForKey("endDate"))
        }
    }
    
    
    @IBAction func getUserData(sender: AnyObject) {
        let user = DataPasser()
        let object = user.getUserData()
        
        if let object = object{
            print(object.valueForKey("journeysCompleted"))
            print(object.valueForKey("journeysNotCompleted"))
        }
    }
    
    
    @IBAction func getPassportData(sender: AnyObject) {
        let passport = DataPasser()
        let object = passport.getPassportData()
        
        if let object = object{
            print(object.valueForKey("completedJourneys"))
            print(object.valueForKey("journeyID"))
            print(object.valueForKey("timesCompleted"))
            print(object.valueForKey("timeToFinishJourney"))
        }
    }
    
    
    
    @IBAction func saveData(sender: AnyObject) {
        let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        let managedContext = appDelegate.managedObjectContext
        
        if journey == nil {
            let progressEntity =  NSEntityDescription.entityForName("JourneyInProgress", inManagedObjectContext: managedContext)
            journey = NSManagedObject(entity: progressEntity!, insertIntoManagedObjectContext:managedContext)
        }
        
        journey?.setValue(NSDate(), forKey: "endDate")
        journey?.setValue(NSDate(), forKey: "startDate")
        journey?.setValue(1, forKey: "journeyID")
        journey?.setValue(999, forKey: "steps")
        
        // Complete save and handle potential error
        do {
            try managedContext.save()
        } catch let error as NSError {
            print("Could not save \(error), \(error.userInfo)")
        }
    }
    


    /*
    // Override to support conditional editing of the table view.
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            // Delete the row from the data source
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
        } else if editingStyle == .Insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(tableView: UITableView, moveRowAtIndexPath fromIndexPath: NSIndexPath, toIndexPath: NSIndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(tableView: UITableView, canMoveRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
