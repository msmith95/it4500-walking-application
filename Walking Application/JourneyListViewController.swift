//
//  JourneyListViewController.swift
//  Walking Application
//
//  Created by Seth vonSeggern on 4/23/16.
//  Copyright © 2016 Walking Team A. All rights reserved.
//

import UIKit
import CoreData
import HealthKit

class JourneyListViewController: UITableViewController {
    let journeyCollection = DataPassing.sharedInstance
    var filteredJourneys: [Journey]!
    var journey: NSManagedObject?
    let HKM = HealthKitManager()
    let dp = DataPasser()
    var jIP: NSManagedObject?
    var jID:Int? = -1
    var journeyMove:NSManagedObject?
    var object:NSManagedObject?

    override func viewDidAppear(animated: Bool){
        self.tableView.reloadData()
        let journey2 = DataPasser()
        object = journey2.getJourneyInProgress()
        if((journey?.valueForKey("journeyID"))! as! NSObject == -1){
            let alert = UIAlertController(title: "No Journey in Progress", message: "You do not have a journey in progress.  Please choose one below to start!", preferredStyle: UIAlertControllerStyle.Alert)
            alert.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.Default, handler: {
                (alertAction) -> Void in
            }))
            self.presentViewController(alert, animated: true, completion: nil)
        }
        
        let healthKitStore:HKHealthStore = HKHealthStore()
        
        // 1. Create a BMI Sample
        let bmiType = HKQuantityType.quantityTypeForIdentifier(HKQuantityTypeIdentifierStepCount)
        let bmiQuantity = HKQuantity(unit: HKUnit.countUnit(), doubleValue: 74.0)
        let bmiSample = HKQuantitySample(type: bmiType!, quantity: bmiQuantity, startDate: NSDate(), endDate: NSDate())
        
        // 2. Save the sample in the store
        healthKitStore.saveObject(bmiSample, withCompletion: { (success, error) -> Void in
            if( error != nil ) {
                print("Error saving Steps sample: \(error!.localizedDescription)")
            } else {
                print("Steps sample saved successfully!")
            }
        })

    }
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        self.view.backgroundColor = UIColor(red: 0.686, green:0.89, blue:0.0078, alpha:1.0)
        
        HKM.authorizeHealthKit()
            {(success, error) in
                print("\(success)")
                print("\(error)")
        }
       
        
        filteredJourneys = journeyCollection.journeys
        print(journeyCollection.journeys.count)
        
        journey = dp.getJourneyInProgress()
        
        let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        let managedContext = appDelegate.managedObjectContext

        //journey = nil
        if journey == nil {
            let noteEntity =  NSEntityDescription.entityForName("JourneyInProgress", inManagedObjectContext: managedContext)
            journey = NSManagedObject(entity: noteEntity!, insertIntoManagedObjectContext:managedContext)
            journey?.setValue(NSDate(), forKey: "endDate")
            journey?.setValue(NSDate(), forKey: "startDate")
            journey?.setValue(-1, forKey: "journeyID")
            journey?.setValue(0, forKey: "steps")
            
        }
        
        // Complete save and handle potential error
        do {
         try managedContext.save()
         print("It saved")
         } catch let error as NSError {
         print("Could not save \(error), \(error.userInfo)")
         }

        
        if(journey?.valueForKey("journeyID") as! Int >= 0){
            jID = journey?.valueForKey("journeyID") as? Int
            self.performSegueWithIdentifier("journeySegue", sender: self)
        }

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
        cell.journeyDistance.text = String(journey.distance) + " miles" + " : " + String(journey.steps) + " steps"
        print(journey.distance)
        
        cell.accessoryType = .DisclosureIndicator//enum
        
        // color text orange on active journey
        
        if let object = object {
            if object.valueForKey("journeyID") as! Int == indexPath.row {
                cell.journeyName.textColor = UIColor.redColor()
                cell.journeyDistance.textColor = UIColor.redColor()
            }else{
                cell.journeyName.textColor = UIColor.darkGrayColor()
                cell.journeyDistance.textColor = UIColor.darkGrayColor()
            }
        }

        return cell
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        self.performSegueWithIdentifier("journeySegue", sender: self)
    }

    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {

        let controller:JourneyViewController = segue.destinationViewController as! JourneyViewController
        
        if let row = self.tableView.indexPathForSelectedRow?.row {
            controller.journey = filteredJourneys[row]
        }else if jID >= 0{
            controller.journey = filteredJourneys[jID!]
            controller.ip = true
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
