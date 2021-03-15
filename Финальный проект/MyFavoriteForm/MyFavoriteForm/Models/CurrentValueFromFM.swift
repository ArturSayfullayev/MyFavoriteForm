//
//  CurrentValueFromFM.swift
//  MyFavoriteForm
//
//  Created by Artur on 28.02.2021.
//

import Foundation

class CurrentValueFromFM: Codable {
    // MARK: - Enums (for Codable usage)
    enum CodingKeys: String, CodingKey {
        case calories = "Calories"
        case proteins = "Proteins"
        case fats = "Fats"
        case carbohydrates = "Carbohydrates"
        case water = "Water"
    }
    
    // MARK: - Struct
    struct Values: Codable {
        var proteins: String
        var fats: String
        var carbohydrates: String
        var calories: String
        var water: String
    }
    
    private var values: Values?
    
    // MARK: - Codable
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)

        try container.encode(Logic.shared.getCurrentCalories(), forKey: .calories)
        try container.encode(Logic.shared.getCurrentProteins(), forKey: .proteins)
        try container.encode(Logic.shared.getCurrentFats(), forKey: .fats)
        try container.encode(Logic.shared.getCurrentCarbohydrates(), forKey: .carbohydrates)
        try container.encode(Logic.shared.getCurrentWater(), forKey: .water)
    }

    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.values = Values(proteins: try container.decode(String.self, forKey: .proteins),
                                fats: try container.decode(String.self, forKey: .fats),
                                carbohydrates: try container.decode(String.self, forKey: .carbohydrates),
                                calories: try container.decode(String.self, forKey: .calories),
                                water: try container.decode(String.self, forKey: .water))
    }
}
