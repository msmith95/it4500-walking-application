//
//  dataPasser.swift
//  dataTest2
//
//  Created by Reiker Seiffe on 4/30/16.
//  Copyright © 2016 Reiker R Seiffe. All rights reserved.
//

import UIKit
import CoreData

class DataPassing: NSObject {
    
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
    
    

    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
}
