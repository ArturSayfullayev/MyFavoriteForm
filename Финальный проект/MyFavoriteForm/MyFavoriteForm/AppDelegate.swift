//
//  AppDelegate.swift
//  MyFavoriteForm
//
//  Created by Artur on 14.02.2021.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {

        self.window = UIWindow(frame: UIScreen.main.bounds)
        // Проверяем: если заходим первый раз - подгружаем базовый набор блюд.
        let menu = FoodFileManager.shared.readDataWithCodable(with: Logic.shared.userKeyMenuCodable)
        if menu == nil {
            FoodFileManager.shared.writeDataWithNSCodable(with: Logic.shared.userKeyMenuCodable,
                                                          model: FoodProductModel.shared.menu)
        }
        
        Logic.shared.setPersonValue()
          
        if let window = self.window {
            let navigationController = UINavigationController(rootViewController: TabBarViewController())
            let viewController = AuthViewController()
            // Если заходим первый раз - запускаем страницу авторизации
            if Logic.shared.person == nil {
                window.rootViewController = viewController
            } else {
                // Если уже есть сохраненный профиль - проверяем дату и обнуляем текущие показания
                let todayDate = Date().formatter()
                let curentDate = Logic.shared.person?.curentDate.formatter()
                if curentDate != todayDate {
                    Logic.shared.resetCurrentValues()
                }
                Logic.shared.writeValuesToFM()
                
                window.rootViewController = navigationController
            }
            window.makeKeyAndVisible()
        }
        
        return true
    }
    func applicationWillResignActive(_ application: UIApplication) {
        DefaultsManager.shared.writeDataToUDWithCodable(for: Logic.shared.userKey, model: Logic.shared.person)
        Logic.shared.writeValuesToFM()
    }
}
