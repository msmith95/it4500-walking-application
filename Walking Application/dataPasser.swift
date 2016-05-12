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
                print(results)
                if(results.count == 0){
                    return nil
                }
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
    
    
    var passPort: NSManagedObject?
    
    func savePassport(completedJourney: Int, journeyID:Int, timeToFinish:Int) {
        let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        let managedContext = appDelegate.managedObjectContext
        
        passPort = nil
        
        if passPort == nil {
            let passportEntity =  NSEntityDescription.entityForName("Passport", inManagedObjectContext: managedContext)
            passPort = NSManagedObject(entity: passportEntity!, insertIntoManagedObjectContext:managedContext)
        }
        
        passPort?.setValue(completedJourney, forKey: "CompletedJourneys")
        passPort?.setValue(journeyID, forKey: "journeyId")
        passPort?.setValue(journeyID, forKey: "journeyId")
        passPort?.setValue(timeToFinish, forKey: "timeToFinishJourney")
        
        // Complete save and handle potential error
        do {
            try managedContext.save()
        } catch let error as NSError {
            print("Could not save \(error), \(error.userInfo)")
        }
        
    }
    
    
    var passportArray = [NSManagedObject]?()
    
    func loadPassports() -> [NSManagedObject]{
        // Load saved passport entities from core data
        let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        let managedContext = appDelegate.managedObjectContext
        let fetchRequest = NSFetchRequest(entityName:"Passport")
        
        do {
            let fetchedResults =
                try managedContext.executeFetchRequest(fetchRequest) as? [NSManagedObject]
            
            if let results = fetchedResults {
                passportArray = results
                return passportArray!
            } else {
                print("Could not fetch notes")
            }
        } catch {
            return []
        }
        return []
    }
    
}
