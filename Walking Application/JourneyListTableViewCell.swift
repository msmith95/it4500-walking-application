//
//  JouneyListTableViewCell.swift
//  Walking Application
//
//  Created by Seth vonSeggern on 5/5/16.
//  Copyright © 2016 Walking Team A. All rights reserved.
//

import UIKit

class JourneyListTableViewCell: UITableViewCell {

    @IBOutlet weak var journeyName: UILabel!
    @IBOutlet weak var journeyDistance: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        journeyName.textColor = UIColor.darkGrayColor()
        journeyDistance.textColor = UIColor.grayColor()
        
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
