//
//  PassportNavigationController.swift
//  Walking Application
//
//  Created by Seth vonSeggern on 5/11/16.
//  Copyright © 2016 Walking Team A. All rights reserved.
//

import UIKit

class PassportNavigationController: UINavigationController {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationBar.barTintColor = UIColor(red: 0.478, green: 0.8, blue: 0.266, alpha: 1.0)
        self.navigationBar.translucent = false

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
