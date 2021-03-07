//
//  FileManager.swift
//  MyFavoriteForm
//
//  Created by Artur on 24.02.2021.
//

import Foundation

class FoodFileManager {
    // MARK: - Static properties
    static let shared = FoodFileManager()
    
    // MARK: - Variables
    private var directoryURL: URL

    // MARK: - Init
    init() {
        self.directoryURL = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
    }
    // MARK: - Methods
    @discardableResult
    func writeDataWithNSCodable(with path: String, model: [FoodModelFromFileManager.Menu]?) -> Bool {
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

    func readDataWithCodable(with path: String) -> [FoodModelFromFileManager.Menu]? {
        let localPath = self.directoryURL.appendingPathComponent(path)

        do {
            let data = try Data(contentsOf: localPath)
            return try? JSONDecoder().decode([FoodModelFromFileManager.Menu].self, from: data)
            
        } catch {
            return nil
        }
    }
}
