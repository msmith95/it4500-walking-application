//
//  Journey.swift
//  Walking Application
//
//  Created by Kyle Whitney on 4/27/16.
//  Copyright © 2016 Walking Team A. All rights reserved.
//

import Foundation


class Journey {
    var fileName: String = ""
    var journeyName: String = ""
    var journeyId: Int
    var description: String = ""
    var steps: Double
    var distance: Double
    
    
    init(fileName: String, journeyName: String, journeyID: Int, description: String, steps: Double, distance: Double) {
        self.fileName = fileName
        self.journeyName = journeyName
        self.journeyId = journeyID
        self.description = description
        self.steps = steps
        self.distance = distance
        
       
    }
    
}