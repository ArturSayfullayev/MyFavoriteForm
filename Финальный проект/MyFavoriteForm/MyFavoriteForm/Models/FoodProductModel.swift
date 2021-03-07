//
//  FoodProductModel.swift
//  MyFavoriteForm
//
//  Created by Artur on 21.02.2021.
//

import Foundation



class FoodProductModel {
    // MARK: - Singleton
    static let shared = FoodProductModel()
    
    // MARK: - Properties
    var menu: [FoodModelFromFileManager.Menu] = [
        FoodModelFromFileManager.Menu(
            name: "картофель", proteins: "1.71", fats: "0.1", carbohydrates: "18.21", calories: "200"),
        FoodModelFromFileManager.Menu(
            name: "курица", proteins: "12", fats: "20", carbohydrates: "15", calories: "200"),
        FoodModelFromFileManager.Menu(
            name: "свинина", proteins: "12", fats: "20", carbohydrates: "15", calories: "200"),
        FoodModelFromFileManager.Menu(
            name: "макароны", proteins: "12", fats: "20", carbohydrates: "15", calories: "200"),
        FoodModelFromFileManager.Menu(
            name: "рис", proteins: "12", fats: "20", carbohydrates: "15", calories: "200"),
        FoodModelFromFileManager.Menu(
            name: "гречка", proteins: "12", fats: "20", carbohydrates: "15", calories: "200"),
        FoodModelFromFileManager.Menu(
            name: "фалафель", proteins: "12", fats: "20", carbohydrates: "15", calories: "200"),
        FoodModelFromFileManager.Menu(
            name: "йогурт", proteins: "12", fats: "20", carbohydrates: "15", calories: "200"),
        FoodModelFromFileManager.Menu(
            name: "томат", proteins: "12", fats: "20", carbohydrates: "15", calories: "200"),
        FoodModelFromFileManager.Menu(
            name: "огурец", proteins: "12", fats: "20", carbohydrates: "15", calories: "200"),
        FoodModelFromFileManager.Menu(
            name: "свекла", proteins: "12", fats: "20", carbohydrates: "15", calories: "200"),
        FoodModelFromFileManager.Menu(
            name: "капуста", proteins: "12", fats: "20", carbohydrates: "15", calories: "200")]
    
    // MARK: - Methods
    func setMenuFromFM(menu: [FoodModelFromFileManager.Menu]) {
        self.menu = menu
    }
}
