//
//  Profile.swift
//  MyFavoriteForm
//
//  Created by Artur on 17.02.2021.
//

import Foundation

class Profile: Codable {
    // MARK: - Enums (for Codable usage)
    enum CodingKeys: String, CodingKey {
        case name = "Name"
        case age = "Age"
        case height = "Height"
        case weight = "Weight"
        case sex = "Sex"
        case target = "Target"
        case action = "Action"
        case dateOfBirthday = "DateOfBirthday"
        case curentDate = "CurentDate"
    }
    
    // MARK: - Enums
    enum Sex: String, CaseIterable, CodingKey {
        case male = "мужской"
        case female = "женский"
        
        var curentDoubleForMethod: Double {
            switch self {
            case .male:
                return -5
            case .female:
                return 161
            }
        }
    }
    enum Action: String, CaseIterable, CodingKey {
        case a = "отсутствует"
        case b = "слабая"
        case c = "средняя"
        case d = "высокая"
        case e = "экстримальная"
        
        var curentDoubleForMethod: Double {
            switch self {
            case .a:
                return 1.2
            case .b:
                return 1.375
            case .c:
                return 1.55
            case .d:
                return 1.7
            case .e:
                return 1.9
            }
        }
    }
    
    enum Target: String, CaseIterable, CodingKey {
        case slim = "похудение"
        case maintaining = "поддержание"
        case gain = "набор массы"
        
        var curentDoubleForMethod: Double {
            switch self {
            case .slim:
                return -230
            case .maintaining:
                return 0
            case .gain:
                return 230
            }
        }
    }

    var name: String
    var age: String
    var height: String
    var weight: String
    var sex: Sex
    var target: Target
    var action: Action
    var dateOfBirthday: String
    var curentDate = Date()
    
    // MARK: - Init
    init(name: String,
         age: String,
         height: String,
         weight: String,
         sex: Sex,
         target: Target,
         action: Action,
         dateOfBirthday: String) {
        self.name = name
        self.age = age
        self.height = height
        self.weight = weight
        self.sex = sex
        self.target = target
        self.action = action
        self.dateOfBirthday = dateOfBirthday
    }

    // MARK: - Codable
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)

        try container.encode(self.name, forKey: .name)
        try container.encode(self.age, forKey: .age)
        try container.encode(self.height, forKey: .height)
        try container.encode(self.weight, forKey: .weight)
        try container.encode(self.sex.rawValue, forKey: .sex)
        try container.encode(self.target.rawValue, forKey: .target)
        try container.encode(self.action.rawValue, forKey: .action)
        try container.encode(self.dateOfBirthday, forKey: .dateOfBirthday)
        try container.encode(self.curentDate, forKey: .curentDate)
    }

    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)

        self.name = try container.decode(String.self, forKey: .name)
        self.age = try container.decode(String.self, forKey: .age)
        self.height = try container.decode(String.self, forKey: .height)
        self.weight = try container.decode(String.self, forKey: .weight)
        self.sex = Profile.Sex(rawValue: try container.decode(String.self, forKey: .sex)) ?? .female
        self.target = Profile.Target(rawValue: try container.decode(String.self, forKey: .target)) ?? .maintaining
        self.action = Profile.Action(rawValue: try container.decode(String.self, forKey: .action)) ?? .b
        self.dateOfBirthday = try container.decode(String.self, forKey: .dateOfBirthday)
        self.curentDate = try container.decode(Date.self, forKey: .curentDate)
    }
}
