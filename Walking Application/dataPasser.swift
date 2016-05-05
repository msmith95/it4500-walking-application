//
//  dataPasser.swift
//  dataTest2
//
//  Created by Reiker Seiffe on 4/30/16.
//  Copyright © 2016 Reiker R Seiffe. All rights reserved.
//

import UIKit
import CoreData

class DataPasser: NSObject {
    
    var date = [NSManagedObject]()
    
    func getJourneyInProgress() -> NSManagedObject?{
        // Load saved note entities from core data
        let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        let managedContext = appDelegate.managedObjectContext
        let fetchRequest = NSFetchRequest(entityName:"JourneyInProgress")
        
        do {
            let fetchedResults =
            try managedContext.executeFetchRequest(fetchRequest) as? [NSManagedObject]
            
            if let results = fetchedResults {
                //print(results)
                return results[0]
            } else {
                print("Could not fetch journey in progress")
            }
        } catch {
            return nil
        }
        return nil
    }
    
    func getUserData() -> NSManagedObject?{
        // Load saved note entities from core data
        let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        let managedContext = appDelegate.managedObjectContext
        let fetchRequest = NSFetchRequest(entityName:"User")
        
        do {
            let fetchedResults =
                try managedContext.executeFetchRequest(fetchRequest) as? [NSManagedObject]
            
            if let results = fetchedResults {
                //print(results)
                return results[0]
            } else {
                print("Could not fetch user data")
            }
        } catch {
            return nil
        }
        return nil
    }
    
    
    func getPassportData() -> NSManagedObject?{
        // Load saved note entities from core data
        let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        let managedContext = appDelegate.managedObjectContext
        let fetchRequest = NSFetchRequest(entityName:"Passport")
        
        do {
            let fetchedResults =
                try managedContext.executeFetchRequest(fetchRequest) as? [NSManagedObject]
            
            if let results = fetchedResults {
                //print(results)
                return results[0]
            } else {
                print("Could not fetch passport data")
            }
        } catch {
            return nil
        }
        return nil
    }
    
    
    
    
    //THIS GOES ONTO A VIEW CONTROLLER TO SAVE DATA
    
    /*@IBAction func saveData(sender: AnyObject) {
        let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        let managedContext = appDelegate.managedObjectContext
        
        if journey == nil {
            let noteEntity =  NSEntityDescription.entityForName("JourneyInProgress", inManagedObjectContext: managedContext)
            journey = NSManagedObject(entity: noteEntity!, insertIntoManagedObjectContext:managedContext)
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
    }*/
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
}
