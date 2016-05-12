//
//  JourneyNavigationController.swift
//  Walking Application
//
//  Created by Michael Smith on 5/11/16.
//  Copyright © 2016 Walking Team A. All rights reserved.
//

import UIKit

class JourneyNavigationController: UINavigationController {

    override func viewDidLoad() {
        super.viewDidLoad()

        self.navigationBar.barTintColor = UIColor(red: 0.0078, green: 0.686, blue: 0.89, alpha: 1.0)
        self.navigationBar.tintColor = UIColor.whiteColor()
        print("It loaded!!!")
        //.0078  .686 .89
        //.686 .89 .0078

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
