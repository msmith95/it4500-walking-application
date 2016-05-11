//
//  HealthKitManager.swift
//  Walking Application
//
//  Created by Michael Smith on 4/21/16.
//  Copyright © 2016 Walking Team A. All rights reserved.
//

import UIKit
import HealthKit

class HealthKitManager: NSObject {
    
    let healthKitStore:HKHealthStore = HKHealthStore()
    
    private var stepsArray = [HKQuantitySample]()
    var steps:Double = 200.00
    
    func authorizeHealthKit(completion: ((success:Bool, error:NSError!) -> Void)!){
        if !HKHealthStore.isHealthDataAvailable()
        {
            print ("Not avaliable")
            let error = NSError(domain: "edu.missouri.cs.HKTest", code: 2, userInfo: [NSLocalizedDescriptionKey:"HealthKit is not available in this Device"])
            if( completion != nil )
            {
                completion(success:false, error:error)
            }
            return;
            
        }
        
        let healthKitTypesToRead = Set(arrayLiteral:
            HKObjectType.quantityTypeForIdentifier(HKQuantityTypeIdentifierStepCount)!,
            HKObjectType.quantityTypeForIdentifier(HKQuantityTypeIdentifierDistanceWalkingRunning)!
        )
        
        healthKitStore.requestAuthorizationToShareTypes(healthKitTypesToRead, readTypes: healthKitTypesToRead) { (success, error) -> Void in
            if( completion != nil )
            {
                completion(success:success,error:error)
            }
        }
    }
    
    func getSteps(startDate:NSDate, completionHandler:(Int?, NSError?)->Void){
        
        let endDate:NSDate = NSDate();
        
        let predicate = HKQuery.predicateForSamplesWithStartDate(startDate, endDate: endDate, options: .StrictStartDate)
        
        
        let stepsCount = HKQuantityType.quantityTypeForIdentifier(
            HKQuantityTypeIdentifierStepCount)
        
        let sumOption = HKStatisticsOptions.CumulativeSum
        
        let statisticsSumQuery = HKStatisticsQuery(quantityType: stepsCount!, quantitySamplePredicate: predicate,
                                                   options: sumOption)
        { (query, result, error) in
            if let sumQuantity = result?.sumQuantity() {
                
                let numberOfSteps = Int(sumQuantity.doubleValueForUnit(HKUnit.countUnit()))
                print(numberOfSteps)
                NSLog(String(numberOfSteps))
                completionHandler(numberOfSteps, error)
            }else{
                 completionHandler(nil, error)
            }
            
        }
        
        // Don't forget to execute the query!
        healthKitStore.executeQuery(statisticsSumQuery)
    }
    
    
    func getDistance(startDate:NSDate, completionHandler:(Float?, NSError?)->Void){
        
        let endDate:NSDate = NSDate();
        
        let predicate = HKQuery.predicateForSamplesWithStartDate(startDate, endDate: endDate, options: .StrictStartDate)
        
        
        let distanceCount = HKQuantityType.quantityTypeForIdentifier(
            HKQuantityTypeIdentifierDistanceWalkingRunning)
        
        let sumOption = HKStatisticsOptions.CumulativeSum
        
        let statisticsSumQuery = HKStatisticsQuery(quantityType: distanceCount!, quantitySamplePredicate: predicate,
                                                   options: sumOption)
        { (query, result, error) in
            if let sumQuantity = result?.sumQuantity() {
                
                let distance = Float(sumQuantity.doubleValueForUnit(HKUnit.mileUnit()))
                print(distance)
                NSLog(String(distance))
                completionHandler(distance, error)
            }else{
                completionHandler(nil, error)
            }
            
        }
        
        // Don't forget to execute the query!
        healthKitStore.executeQuery(statisticsSumQuery)
    }
}
