//
//  ProfileDataHealthKit.swift
//  MyFavoriteForm
//
//  Created by Artur on 12.03.2021.
//

import HealthKit

class ProfileDataHealthKit {
    /// Получениеи количества шагов из iHealth
    class func getTodaysSteps(completion: @escaping (Double) -> Void) {
        guard let stepsQuantityType = HKQuantityType.quantityType(forIdentifier: .stepCount) else { return }
        
        let now = Date()
        let startOfDay = Calendar.current.startOfDay(for: now)
        let predicate = HKQuery.predicateForSamples(withStart: startOfDay,
                                                    end: now,
                                                    options: .strictStartDate)
        
        let query = HKStatisticsQuery(quantityType: stepsQuantityType,
                                      quantitySamplePredicate: predicate,
                                      options: .cumulativeSum) { (_, result, _) in
            DispatchQueue.main.async {
                guard let result = result,
                      let summ = result.sumQuantity() else {
                    completion(0.0)
                    return
                }
                completion(summ.doubleValue(for: HKUnit.count()))
            }
        }
        HKHealthStore().execute(query)
    }
    
    /// Получениеи количества сожженной энергии(калорий) из iHealth
    class func getTodaysEnergy(completion: @escaping (Double) -> Void) {
        guard let energyBurn = HKQuantityType.quantityType(forIdentifier: .activeEnergyBurned) else { return }
        
        let now = Date()
        let startOfDay = Calendar.current.startOfDay(for: now)
        let predicate = HKQuery.predicateForSamples(withStart: startOfDay,
                                                    end: now,
                                                    options: .strictStartDate)
        
        let query = HKStatisticsQuery(quantityType: energyBurn,
                                      quantitySamplePredicate: predicate,
                                      options: .cumulativeSum) { (_, result, _) in
            DispatchQueue.main.async {
                guard let result = result,
                      let summ = result.sumQuantity() else {
                    completion(0.0)
                    return
                }
                completion(summ.doubleValue(for: HKUnit.kilocalorie()))
            }
        }
        HKHealthStore().execute(query)
    }
}
