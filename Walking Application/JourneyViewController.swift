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
    var id: Int?
    var name: String?
    var totalSteps : Double?
    var journeyElse:NSManagedObject?
    var stepsTaken : Double?
    let HKM = HealthKitManager()
    let dp = DataPasser()
    var startDate:NSDate?
    var ip:Bool = false

    
    @IBOutlet weak var journeyView: UIImageView!
    @IBOutlet weak var journeyProgress: UIProgressView!
    @IBOutlet weak var journeyDescription: UITextView!
    @IBOutlet weak var journeyDistance: UITextView!
    @IBOutlet weak var journeyStart: UIButton!
    
    
    override func viewWillAppear(animated: Bool) {
        
        let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        let managedContext = appDelegate.managedObjectContext
        
        journeyElse = dp.getJourneyInProgress()
        
        if(journeyElse?.valueForKey("journeyID")! as? NSObject == id){
            journeyProgress.hidden = false
            journeyStart.hidden = true
            HKM.getSteps(journeyElse?.valueForKey("startDate") as! NSDate)
            {(steps:Int?, error:NSError?) in
                var trueSteps:Int?
                if(steps == nil){
                    trueSteps = 0
                }else{
                    trueSteps = steps
                }
                self.journeyElse?.setValue(trueSteps, forKey: "steps")
                print("HK steps \(steps)")
                print("HK error \(error)")
                do {
                    try managedContext.save()
                    print("Updated JIP steps")
                } catch let error as NSError {
                    print("Could not save \(error), \(error.userInfo)")
                }
                
            }
            journeyProgress.progress = Float(Double((journeyElse?.valueForKey("steps"))! as! NSNumber) / totalSteps!)
       
        }
    }
    
    override func viewDidAppear(animated: Bool) {
        if(ip){
            //self.navigationController?.viewControllers = [self]
            self.navigationController?.navigationItem.hidesBackButton = true
        }
    
            if((journeyElse?.valueForKey("steps"))! as? Double >= journey?.steps){
                let alert = UIAlertController(title: "Journey Completed", message: "A stamp has been added to your passport.  Go out there and start another", preferredStyle: UIAlertControllerStyle.Alert)
                alert.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.Default, handler: {
                    (alertAction) -> Void in
                }))
                self.presentViewController(alert, animated: true, completion: nil)
            }
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor(red: 0.686, green:0.89, blue:0.0078, alpha:1.0)
        journeyDescription.backgroundColor = UIColor(red: 0.686, green:0.89, blue:0.0078, alpha:1.0)
        journeyDistance.backgroundColor = UIColor(red: 0.686, green:0.89, blue:0.0078, alpha:1.0)
        journeyStart.backgroundColor = UIColor(red: 0.0078, green: 0.686, blue: 0.89, alpha: 1.0)
        journeyStart.setTitleColor(UIColor.whiteColor(), forState: UIControlState.Normal)
        
        journeyStart.layer.cornerRadius = 5
        journeyProgress.hidden = true
        journeyStart.hidden = false
        
        if let j = journey {
            id = j.journeyId
            name = j.journeyName
            totalSteps = j.steps
            journeyDescription.text = j.description
            journeyDescription.textAlignment = NSTextAlignment.Center
            journeyDescription.textColor = UIColor.darkGrayColor()
            journeyDescription.font = UIFont.systemFontOfSize(17, weight: UIFontWeightMedium)
            journeyDistance.text = String(j.distance) + " miles" 
            journeyDistance.textAlignment = NSTextAlignment.Center
            journeyDistance.textColor = UIColor.darkGrayColor()
            journeyDistance.font = UIFont.systemFontOfSize(17, weight: UIFontWeightMedium)
            journeyView.image = UIImage(named: j.fileName)

        }
        
        
            //print("JIP \(journeyElse?.valueForKey("steps"))")
            //print("JIP ID \(journeyElse?.valueForKey("journeyID"))")
        
       
        
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
            stepsTaken = object.valueForKey("steps") as? Double
            if object.valueForKey("journeyID") as! Int > 0 {
                print("It Worked")
                let alert = UIAlertController(title: "Override Journey", message: "You already have a journey in progress. Do you want to override the current one? Doing so will delete your current progress", preferredStyle: UIAlertControllerStyle.Alert)
                alert.addAction(UIAlertAction(title: "Cancel", style: UIAlertActionStyle.Cancel, handler: {
                    (alertAction) -> Void in
                }))
                alert.addAction(UIAlertAction(title: "Override", style: UIAlertActionStyle.Destructive, handler: {
                    (alertAction) -> Void in
                    self.startJourney()
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
        journeyElse?.setValue(id, forKey: "journeyID") //Need var to hold id of selected journey
        journeyElse?.setValue(0, forKey: "steps")
        
        // Complete save and handle potential error
        do {
            try managedContext.save()
        } catch let error as NSError {
            print("Could not save \(error), \(error.userInfo)")
        }
        journeyProgress.hidden = false
        journeyStart.hidden = true
        journeyProgress.progress = Float (stepsTaken!/totalSteps!)
        print(stepsTaken)
        print(totalSteps)
        print(stepsTaken!/totalSteps!)
    }
}

