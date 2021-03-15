//
//  DefaultsManager.swift
//  MyFavoriteForm
//
//  Created by Artur on 24.02.2021.
//

import Foundation

class DefaultsManager {
    // MARK: - Static properties
    static let shared = DefaultsManager()
    
    // MARK: - Methods
    @discardableResult
    func writeDataToUDWithCodable(for key: String,
                                model: Profile?) -> Bool {
        guard let model = model,
              let data = try? JSONEncoder().encode(model) else {
            return false
        }
        UserDefaults.standard.setValue(data, forKey: key)
        return true
    }

    func readDataFromUDWithCodable(for key: String) -> Profile? {
        guard let data = UserDefaults.standard.data(forKey: key) else {
            return nil
        }
        return try? JSONDecoder().decode(Profile.self, from: data)
    }
}
