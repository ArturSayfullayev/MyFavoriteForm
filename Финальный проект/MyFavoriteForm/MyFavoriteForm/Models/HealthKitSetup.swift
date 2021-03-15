//
//  HealthKitSetup.swift
//  MyFavoriteForm
//
//  Created by Artur on 11.03.2021.
//

import HealthKit

class HealthKitSetupAssistant {
    
    private enum HealthkitSetupError: Error {
        case notAvailableOnDevice
        case dataTypeNotAvailable
    }
    
    class func authorizeHealthKit(completion: @escaping (Bool, Error?) -> Void) {
        // Проверка доступности на устройстве HealthKit
        guard HKHealthStore.isHealthDataAvailable() else {
            completion(false, HealthkitSetupError.notAvailableOnDevice)
            return
        }
        
        // Подготовка данных, которые будут взаимодействовать с HealthKit
        guard  let steps = HKQuantityType.quantityType(forIdentifier: .stepCount),
               let activeEnergy = HKObjectType.quantityType(forIdentifier: .activeEnergyBurned) else {
            
            completion(false, HealthkitSetupError.dataTypeNotAvailable)
            return
        }
        
        // Подготовка типов, которые HealthKit должен считывать
        
        let healthKitTypesToRead: Set<HKObjectType> = [steps, activeEnergy]
        // Запрос на авторизацию
        HKHealthStore().requestAuthorization(toShare: nil,
                                             read: healthKitTypesToRead) { (success, error) in
            completion(success, error)
        }
    }
}
