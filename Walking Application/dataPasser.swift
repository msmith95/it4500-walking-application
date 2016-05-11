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
    
    
    
    
    
    //VARS TO USE//
    //completedJourneysString
    //jounrneyIDString
    //timesCompletedString
    //timeToFinishJourneyString
    
    
    var passportData:NSManagedObject?
    
    func saveCompletedJourney(){
        
        let journey = DataPasser()
        let object = journey.getPassportData()
        passportData = object
        
        
        
        
        let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        let managedContext = appDelegate.managedObjectContext
        
        if passportData == nil {
            let noteEntity =  NSEntityDescription.entityForName("Passport", inManagedObjectContext: managedContext)
            passportData = NSManagedObject(entity: noteEntity!, insertIntoManagedObjectContext:managedContext)
        }
        
        
        passportData?.setValue(completedJourneysString, forKey: CompletedJourneys)
        passportData?.setValue(jounrneyIDString, forKey: journeyId)
        passportData?.setValue(timesCompletedString, forKey: timesCompleted)
        passportData?.setValue(timeToFinishJourneyString, forKey: timeToFinishJounrey)
        
        
        
        // Complete save and handle potential error
        do {
            try managedContext.save()
        } catch let error as NSError {
            print("Could not save \(error), \(error.userInfo)")
        }
    
    
    }
    
    
    
    
    
    
    
    
    
    
    
    
    
    
}
