//
//  DataPassing.swift
//  Walking Application
//
//  Created by Reiker Seiffe on 4/21/16.
//  Copyright © 2016 Walking Team A. All rights reserved.
//

import UIKit
import CoreData
import Foundation

class DataPassing {
    
    static let sharedInstance = DataPassing(fileName: "journeys")
    
    private init(fileName: String){
        loadFromJSONFile(fileName)
    }
    
    static let sharedInstance = DataPassing(fileName: "photos")//a singleton a single instance of a object
    
    private init(fileName:String) {//constructor
        loadFromJSONFile(fileName)
    }
    var journeys:[Journey] = Array<Journey>()//new photo array
    
    private func loadFromJSONFile(fileName: String) {//: builds a new object
        let bundle = NSBundle.mainBundle()//points to its own self bundle
        if let path = bundle.pathForResource(fileName, ofType: "json"), jsonData = NSData(contentsOfFile: path) {
            parseJson(jsonData)//gets the photo.json file -- (compound if let statement) if 1 fails both fail
        }//both need to be true or fails
    }
    private func parseJson(jsonData: NSData) {
        journeys = Array<Journey>()//emptys array
        var jsonResultWrapped: NSDictionary?//
        do {//do try catch
            jsonResultWrapped = try NSJSONSerialization.JSONObjectWithData(jsonData, options: NSJSONReadingOptions.MutableContainers) as? NSDictionary//casts as NSDictionary
        } catch {
            return
        }
        
        if let jsonResult = jsonResultWrapped where jsonResult.count > 0 {//makes sure there is results
            if let status = jsonResult["status"] as? String where status == "ok" {//checks status
                if let journeyList = jsonResult["journeys"] as? NSArray {//casts photo array as a NSArray
                    for journeys in journeyList{
                        if let journeyName = journeys["journeyName"] as? String,
                            journeyID = journeys["journeyID"] as? Int,
                            description = journeys["description"] as? String,
                            steps = journeys["steps"] as? Double,
                            distance = journeys["distance"] as? Double
                            {
                            
                            self.journeys.append(Journey(journeyName: journeyName, journeyID: journeyID, description: description,
                                steps: steps, distance: distance))
                        }
                    }
                }
            }
        }
    }

    
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
