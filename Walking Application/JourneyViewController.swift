//
//  JourneyViewController.swift
//  Walking Application
//
//  Created by Seth vonSeggern on 4/27/16.
//  Copyright © 2016 Walking Team A. All rights reserved.
//

import UIKit



class JourneyViewController: UIViewController {
    var journey:Journey?

    @IBOutlet weak var journeyProgress: UIProgressView!
    @IBOutlet weak var journeyDescription: UILabel!
    @IBOutlet weak var journeyDistance: UILabel!
    @IBOutlet weak var journeyStart: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "Journey"
        
        if let j = journey {
            
            journeyDescription.text = j.description
            
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

}
