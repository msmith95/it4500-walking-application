//
//  DataPassing.swift
//  Walking Application
//
//  Created by Reiker Seiffe on 4/21/16.
//  Copyright © 2016 Walking Team A. All rights reserved.
//

import UIKit
import CoreData

class DataPassing: NSObject {
    
    var date = [NSManagedObject]()
    
    /*
    func loadNotes(){
        // Load saved note entities from core data
        let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        let managedContext = appDelegate.managedObjectContext
        let fetchRequest = NSFetchRequest(entityName:"Note")
        
        do {
            let fetchedResults =
            try managedContext.executeFetchRequest(fetchRequest) as? [NSManagedObject]
            
            if let results = fetchedResults {
                notes = results
            } else {
                print("Could not fetch notes")
            }
        } catch {
            return
        }
    }
*/

    
    
    
    
    
    func loadDate(){
        // Load saved note entities from core data
        let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        let managedContext = appDelegate.managedObjectContext
        let fetchRequest = NSFetchRequest(entityName:"JourneyInProgress")
        
        do {
            let fetchedResults =
            try managedContext.executeFetchRequest(fetchRequest) as? [NSManagedObject]
            
            if let results = fetchedResults {
                date = results
                print(results)
            } else {
                print("Could not fetch Date")
            }
        } catch {
            return
        }
    }

}
