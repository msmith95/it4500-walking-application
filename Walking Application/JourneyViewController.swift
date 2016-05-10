//
//  JourneyViewController.swift
//  Walking Application
//
//  Created by Seth vonSeggern on 4/27/16.
//  Copyright © 2016 Walking Team A. All rights reserved.
//

import UIKit
import CoreData



class JourneyViewController: UIViewController {
    var journey:Journey?

    var journeyElse:NSManagedObject?

    @IBOutlet weak var journeyView: UIImageView!
    @IBOutlet weak var journeyProgress: UIProgressView!
    @IBOutlet weak var journeyDescription: UITextView!
    @IBOutlet weak var journeyDistance: UITextView!
    @IBOutlet weak var journeyStart: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "Journey"
        self.view.backgroundColor = UIColor(red: 0.07, green:0.94, blue:0.63, alpha:1.0)
        journeyDescription.backgroundColor = UIColor(red: 0.07, green:0.94, blue:0.63, alpha:1.0)
        journeyDistance.backgroundColor = UIColor(red: 0.07, green:0.94, blue:0.63, alpha:1.0)
        journeyStart.backgroundColor = UIColor.whiteColor()
        journeyStart.layer.cornerRadius = 5
        
        
        
        if let j = journey {
            
            journeyDescription.text = j.description
            journeyDescription.textAlignment = NSTextAlignment.Center
            journeyDescription.textColor = UIColor.whiteColor()
            journeyDescription.font = UIFont.systemFontOfSize(17, weight: UIFontWeightMedium)
            journeyDistance.text = String(j.distance)
            journeyDistance.textAlignment = NSTextAlignment.Center
            journeyDistance.textColor = UIColor.whiteColor()
            journeyDistance.font = UIFont.systemFontOfSize(17, weight: UIFontWeightMedium)
            // don't have images journeyView.image = UIImage(named: "\(j.fileName)") 
        }
        
        
       
        
        // check core data for in-progress journey
        // if no, segue to no journey view
        // else load json into labels

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    @IBAction func journeyTrigger(sender: AnyObject) {
        let journey = DataPasser()
        let object = journey.getJourneyInProgress()
        if let object = object {
            if object.valueForKey("journeyID") as! Int > 0 {
                print("It Worked")
                let alert = UIAlertController(title: "Override Journey", message: "You already have a journey in progress. Do you want to override the current one? Doing so will delete your current progress", preferredStyle: UIAlertControllerStyle.Alert)
                alert.addAction(UIAlertAction(title: "Cancel", style: UIAlertActionStyle.Cancel, handler: {
                    (alertAction) -> Void in
                }))
                alert.addAction(UIAlertAction(title: "Override", style: UIAlertActionStyle.Destructive, handler: {
                    (alertAction) -> Void in
                    // delete core data, startJourney()
                }))
                self.presentViewController(alert, animated: true, completion: nil)
            }
            else {
                journeyElse = object
                startJourney()
            }
        }
    }
    
    func startJourney(){
        let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        let managedContext = appDelegate.managedObjectContext
        
        if journeyElse == nil {
            let noteEntity =  NSEntityDescription.entityForName("JourneyInProgress", inManagedObjectContext: managedContext)
            journeyElse = NSManagedObject(entity: noteEntity!, insertIntoManagedObjectContext:managedContext)
        }
        
        journeyElse?.setValue(NSDate(), forKey: "endDate")
        journeyElse?.setValue(NSDate(), forKey: "startDate")
        journeyElse?.setValue(1, forKey: "journeyID") //Need var to hold id of selected journey
        journeyElse?.setValue(0, forKey: "steps")
        
        // Complete save and handle potential error
        do {
            try managedContext.save()
        } catch let error as NSError {
            print("Could not save \(error), \(error.userInfo)")
        }
    }
}

