//
//  FoodModelFromFileManager.swift
//  MyFavoriteForm
//
//  Created by Artur on 28.02.2021.
//

import Foundation

class FoodModelFromFileManager: Codable {
    // MARK: - Enums (for Codable usage)
    enum CodingKeys: String, CodingKey {
        case menu = "Menu"
    }
    
    // MARK: - Structs
    struct Menu: Codable {
        var name: String
        var proteins: String
        var fats: String
        var carbohydrates: String
        var calories: String
    }
    
    // MARK: - Properties
    private var menu: [Menu] = []
    
    // MARK: - Codable
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)

        try container.encode(FoodProductModel.shared.menu, forKey: .menu)
    }

    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)

        self.menu = try container.decode([FoodModelFromFileManager.Menu].self, forKey: .menu)
    }
}
