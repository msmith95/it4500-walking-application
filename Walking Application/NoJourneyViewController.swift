//
//  NoJourneyViewController.swift
//  Walking Application
//
//  Created by Seth vonSeggern on 4/27/16.
//  Copyright © 2016 Walking Team A. All rights reserved.
//

import UIKit

class NoJourneyViewController: UIViewController {

    @IBOutlet weak var NoJourneyLabel: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        NoJourneyLabel.text = "You have either completed a journey or not started one yet. Please select one by clicking 'Start' in the upper right hand corner."

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
