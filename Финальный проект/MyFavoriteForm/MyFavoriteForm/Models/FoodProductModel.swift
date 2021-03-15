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
            name: "Картофель", proteins: "1.71", fats: "0.1", carbohydrates: "18.21", calories: "200"),
        FoodModelFromFileManager.Menu(
            name: "Шампиньоны свежие", proteins: "4.3", fats: "1.0", carbohydrates: "0.1", calories: "27"),
        FoodModelFromFileManager.Menu(
            name: "Колбаса вар. молочная", proteins: "11.7", fats: "22.8", carbohydrates: "0.2", calories: "252"),
        FoodModelFromFileManager.Menu(
            name: "Гречневая крупа", proteins: "13.0", fats: "3.0", carbohydrates: "68", calories: "340"),
        FoodModelFromFileManager.Menu(
            name: "Овсяная крупа", proteins: "12.3", fats: "6.1", carbohydrates: "59.5", calories: "342"),
        FoodModelFromFileManager.Menu(
            name: "Овсяные хлопья(геркулес)", proteins: "12.5", fats: "6.2", carbohydrates: "61", calories: "352"),
        FoodModelFromFileManager.Menu(
            name: "Перловая крупа", proteins: "9.3", fats: "1.1", carbohydrates: "73.7", calories: "320"),
        FoodModelFromFileManager.Menu(
            name: "Рисовая крупа", proteins: "7.0", fats: "1.0", carbohydrates: "74.0", calories: "333"),
        FoodModelFromFileManager.Menu(
            name: "Масло сливочное 60%", proteins: "1.3", fats: "60.0", carbohydrates: "1.7", calories: "552"),
        FoodModelFromFileManager.Menu(
            name: "Масло оливковое", proteins: "0", fats: "99.8", carbohydrates: "0", calories: "898"),
        FoodModelFromFileManager.Menu(
            name: "Кефир 1%", proteins: "2.8", fats: "1.0", carbohydrates: "4.0", calories: "40"),
        FoodModelFromFileManager.Menu(
            name: "Молоко 3.2%", proteins: "2.9", fats: "3.2", carbohydrates: "4.7", calories: "59"),
        FoodModelFromFileManager.Menu(
            name: "Молоко козье", proteins: "3.6", fats: "3.3", carbohydrates: "4.8", calories: "68"),
        FoodModelFromFileManager.Menu(
            name: "Блины", proteins: "6.1", fats: "12.3", carbohydrates: "26", calories: "233"),
        FoodModelFromFileManager.Menu(
            name: "Лапша домашняя", proteins: "12.0", fats: "3.7", carbohydrates: "60.1", calories: "322"),
        FoodModelFromFileManager.Menu(
            name: "Макароны(в.с.)", proteins: "10.4", fats: "1.1", carbohydrates: "69.7", calories: "337"),
        FoodModelFromFileManager.Menu(
            name: "Мука пшеничная(в.с.)", proteins: "10.3", fats: "1.1", carbohydrates: "68.9", calories: "334"),
        FoodModelFromFileManager.Menu(
            name: "Пельмени(гов. + св.)", proteins: "11.0", fats: "14.0", carbohydrates: "25.0", calories: "270"),
        FoodModelFromFileManager.Menu(
            name: "Спагетти", proteins: "10.4", fats: "1.1", carbohydrates: "71.5", calories: "344"),
        FoodModelFromFileManager.Menu(
            name: "Баранина", proteins: "15.6", fats: "16.3", carbohydrates: "0", calories: "209"),
        FoodModelFromFileManager.Menu(
            name: "Ветчина", proteins: "14.0", fats: "24.0", carbohydrates: "0", calories: "270"),
        FoodModelFromFileManager.Menu(
            name: "Говядина", proteins: "18.9", fats: "12.4", carbohydrates: "0", calories: "187"),
        FoodModelFromFileManager.Menu(
            name: "Котлеты куриные", proteins: "18.2", fats: "10.4", carbohydrates: "13.8", calories: "222"),
        FoodModelFromFileManager.Menu(
            name: "Котлеты свиные", proteins: "13.6", fats: "45.7", carbohydrates: "0", calories: "466"),
        FoodModelFromFileManager.Menu(
            name: "Куриная грудка", proteins: "23.6", fats: "1.9", carbohydrates: "0.4", calories: "113"),
        FoodModelFromFileManager.Menu(
            name: "Апельсин", proteins: "0.9", fats: "0.2", carbohydrates: "8.1", calories: "36"),
        FoodModelFromFileManager.Menu(
            name: "Банан", proteins: "1.5", fats: "0.2", carbohydrates: "21.8", calories: "95"),
        FoodModelFromFileManager.Menu(
            name: "Творог 1%", proteins: "16.3", fats: "1.0", carbohydrates: "1.3", calories: "79")]
    
    // MARK: - Methods
    func setMenuFromFM(menu: [FoodModelFromFileManager.Menu]) {
        self.menu = menu
    }
}
