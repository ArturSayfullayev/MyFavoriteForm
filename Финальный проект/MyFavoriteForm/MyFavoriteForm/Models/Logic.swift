//
//  Logic.swift
//  MyFavoriteForm
//
//  Created by Artur on 23.02.2021.
//

import Foundation

class Logic {
    // MARK: - Structures
    struct AllProperties {
        var calories: Double
        var proteins: Double
        var fats: Double
        var carbohydrates: Double
    }
    struct AllPropertiesString {
        var name: String
        var calories: String
        var proteins: String
        var fats: String
        var carbohydrates: String
    }
    
    // MARK: - Properties
    static let shared = Logic()
    
    private(set) var formateDateDMY = "dd.MM.yyyy"
    private(set) var person: Profile?
    private(set) var userKey = "UserKey"
    private(set) var userKeyMenuCodable = "userKeyMenuCodable"
    private(set) var userKeyEnergyCodable = "userKeyEnergyCodable"
    
    private var currentCalories: Double = 0
    private var currentProteins: Double = 0
    private var currentFats: Double = 0
    private var currentCarbohydrates: Double = 0
    private var currentWater: Double = 0
    
    private var allProperties: AllProperties?
    private var needWater: String?
    
    private var additionalMenu: [FoodModelFromFileManager.Menu] = []

    // MARK: - Methods
    /// Метод очистки временной переменной
    private func deleteAddMenu() {
        self.additionalMenu.removeAll()
    }
    
    func setPropertiesFromData(properties: AllProperties, water: Double) {
        self.currentCalories = properties.calories
        self.currentProteins = properties.proteins
        self.currentFats = properties.fats
        self.currentCarbohydrates = properties.carbohydrates
        self.currentWater = water
    }
    
    func setCalories(bool: Bool, properties: AllProperties? = nil) {
        if bool {
        self.allProperties = self.getCalories()
        } else {
            self.allProperties = properties
        }
    }
  
    /// Формула рассчета калорий, белков, жиров, углеводов и воды.
    func getCalories() -> AllProperties? {
        let age: Double = Double(String(self.person?.age ?? "0")) ?? 0
        let height: Double = Double(String(self.person?.height ?? "0")) ?? 0
        let weight: Double = Double(String(self.person?.weight ?? "0")) ?? 0
        
        guard let person = self.person,
              !age.isZero,
              !height.isZero,
              !weight.isZero else { return nil }
       
        let calories = (10 * weight + 6.25 * height - 5 * age - person.sex.curentDoubleForMethod) * person.action.curentDoubleForMethod + person.target.curentDoubleForMethod
        
        var proteins: Double = 0
        var fats: Double = 0
        var carbohydrates: Double = 0

        switch person.target {
        case .maintaining:
            proteins = calories * 0.3 / 4
            fats = calories * 0.3 / 9
            carbohydrates = calories * 0.4 / 4
        case .slim:
            proteins = calories * 0.3 / 4
            fats = calories * 0.2 / 9
            carbohydrates = calories * 0.5 / 4
        case .gain:
            proteins = calories * 0.35 / 4
            fats = calories * 0.15 / 9
            carbohydrates = calories * 0.5 / 4
        }
        return AllProperties(calories: calories, proteins: proteins, fats: fats, carbohydrates: carbohydrates)
    }
    
    /// Формула рассчета воды
    func setWater(bool: Bool, water: String? = nil) {
        if bool {
        guard let person = self.person,
              let weight = Double(person.weight),
              weight != 0 else { return }
            self.needWater = (weight * 30).formatter()
        } else {
            guard let water = water else { return }
            self.needWater = water
        }
    }
    func getWater() -> String {
        return self.needWater ?? "0"
    }
    
    // Методы получения значений калорий, белков, жиров, углеводов.
    func getCalories() -> String {
        let calories: Double = self.allProperties?.calories ?? 0
        return calories.formatter()
    }
    func getProteins() -> String {
        let proteins: Double = self.allProperties?.proteins ?? 0
        return proteins.formatter()
    }
    func getFats() -> String {
        let fats: Double = self.allProperties?.fats ?? 0
        return fats.formatter()
    }
    func getCarbohydrates() -> String {
        let carbohydrates: Double = self.allProperties?.carbohydrates ?? 0
        return carbohydrates.formatter()
    }
    
    // Методы получения текущих значений
    func getCurrentCalories() -> String {
        self.currentCalories.formatter()
    }
    func getCurrentProteins() -> String {
        self.currentProteins.formatter()
    }
    func getCurrentFats() -> String {
        self.currentFats.formatter()
    }
    func getCurrentCarbohydrates() -> String {
        self.currentCarbohydrates.formatter()
    }
    func getCurrentWater() -> String {
        self.currentWater.formatter()
    }
    
    // Формулы рассчета текущего процента
    func getPercentCalories() -> Int {
        Int(self.currentCalories / Double(self.allProperties?.calories ?? 0) * 100)
    }
    func getPercentProteins() -> Double {
        self.currentProteins / Double(self.allProperties?.proteins ?? 0)
    }
    func getPercentFats() -> Double {
        self.currentFats / Double(self.allProperties?.fats ?? 0)
    }
    func getPercentCarbohydrates() -> Double {
        self.currentCarbohydrates / Double(self.allProperties?.carbohydrates ?? 0)
    }
    func getPercentWater() -> Double {
        self.currentWater / (Double(self.needWater ?? "0") ?? 0)
    }
    
    /// Метод заполнения текущего значения воды
    func setWater(water: String) {
        guard let water = Double(water) else { return }
        self.currentWater += water
    }
    
    /// Метод добавления во временную переменную
    func setAdditionalMenu(menu: FoodModelFromFileManager.Menu) {
        self.additionalMenu.append(FoodModelFromFileManager.Menu(name: menu.name,
                                                                 proteins: menu.proteins,
                                                                 fats: menu.fats,
                                                                 carbohydrates: menu.carbohydrates,
                                                                 calories: menu.calories))
    }
    
    /// Метод рассчета всех показателей на конкретную массу и добавления показателей в переменные
    func setEnergyFromFood(mass: String) {
        guard self.additionalMenu.count > 0,
              let proteins = Double(self.additionalMenu[self.additionalMenu.count - 1].proteins),
              let fats = Double(self.additionalMenu[self.additionalMenu.count - 1].fats),
              let carbohydrates = Double(self.additionalMenu[self.additionalMenu.count - 1].carbohydrates),
              let calories = Double(self.additionalMenu[self.additionalMenu.count - 1].calories),
              let mass = Double(mass) else { return }
        
        self.currentProteins += (proteins / 100 * mass)
        self.currentFats += (fats / 100 * mass)
        self.currentCarbohydrates += (carbohydrates / 100 * mass)
        self.currentCalories += (calories / 100 * mass)
        self.deleteAddMenu()
    }
    
    /// Метод показа всех показателей до добавления
    func presentEnergy(mass: String) -> (AllPropertiesString)? {
        guard self.additionalMenu.count > 0,
              let proteins = Double(self.additionalMenu[self.additionalMenu.count - 1].proteins),
              let fats = Double(self.additionalMenu[self.additionalMenu.count - 1].fats),
              let carbohydrates = Double(self.additionalMenu[self.additionalMenu.count - 1].carbohydrates),
              let calories = Double(self.additionalMenu[self.additionalMenu.count - 1].calories),
              let mass = Double(mass) else { return nil }
       
        return AllPropertiesString(name: self.additionalMenu[self.additionalMenu.count - 1].name,
                                   calories: (calories / 100 * mass).formatter(),
                                   proteins: (proteins / 100 * mass).formatter(),
                                   fats: (fats / 100 * mass).formatter(),
                                   carbohydrates: (carbohydrates / 100 * mass).formatter())
    }
    
    /// Обнуление текущих показателей
    func resetCurrentValues() {
        self.currentCalories = 0
        self.currentProteins = 0
        self.currentFats = 0
        self.currentCarbohydrates = 0
        self.currentWater = 0
    }
    
    // MARK: - Setter
    func setPersonValue() {
        guard let profile = DefaultsManager.shared.readDataFromUDWithCodable(
                for: self.userKey) else { return }
        self.person = profile
    }
    
    func setCurentValuesFromFM() {
        guard let values = CurrentAndNeedingEnergy.shared.readDataWithCodable(
                with: self.userKeyEnergyCodable) else { return }
        guard let calories = Double(values.calories),
        let fats = Double(values.fats),
        let carbohydrates = Double(values.carbohydrates),
        let proteins = Double(values.proteins),
        let water = Double(values.water) else { return }
        
        self.setPropertiesFromData(properties: AllProperties(calories: calories,
                                                             proteins: proteins,
                                                             fats: fats,
                                                             carbohydrates: carbohydrates),
                                                        water: water)
    }
    
    func writeValuesToFM() {
        let model = CurrentValueFromFM.Values(proteins: self.getCurrentProteins(),
                                              fats: self.getCurrentFats(),
                                              carbohydrates: self.getCurrentCarbohydrates(),
                                              calories: self.getCurrentCalories(),
                                              water: self.getCurrentWater())
        
        CurrentAndNeedingEnergy.shared.writeDataWithNSCodable(with: self.userKeyEnergyCodable,
                                                              model: model)
    }
}
