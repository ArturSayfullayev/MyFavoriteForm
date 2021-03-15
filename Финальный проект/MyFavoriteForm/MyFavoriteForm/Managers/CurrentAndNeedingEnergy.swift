//
//  CurrentAndNeedingEnergy.swift
//  MyFavoriteForm
//
//  Created by Artur on 28.02.2021.
//

import Foundation

class CurrentAndNeedingEnergy: Codable {
    // MARK: - Static properties
    static let shared = CurrentAndNeedingEnergy()
    
    // MARK: - Variables
    private var directoryURL: URL

    // MARK: - Init
    init() {
        self.directoryURL = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
    }
    // MARK: - Methods
    @discardableResult
    func writeDataWithNSCodable(with path: String, model: CurrentValueFromFM.Values?) -> Bool {
        let localPath = self.directoryURL.appendingPathComponent(path)

        guard let model = model else { return false }
        let encodedData = try? JSONEncoder().encode(model)
        do {
            try encodedData?.write(to: localPath)
            return true
        } catch {
            return false
        }
    }

    func readDataWithCodable(with path: String) -> CurrentValueFromFM.Values? {
        let localPath = self.directoryURL.appendingPathComponent(path)

        do {
            let data = try Data(contentsOf: localPath)
            return try? JSONDecoder().decode(CurrentValueFromFM.Values.self, from: data)
            
        } catch {
            return nil
        }
    }
}

