//
//  TabBarController.swift
//  MyFavoriteForm
//
//  Created by Artur on 19.02.2021.
//

import UIKit

class TabBarViewController: UITabBarController {
    // MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()

        self.setTabBarItems()
    }
    // MARK: - Methods
    private func setTabBarItems() {
        let main = MainViewController()
        let second = UINavigationController(rootViewController: PersonViewController())
        
        self.tabBarController?.tabBar.barStyle = .black
        self.tabBar.backgroundColor = .systemGreen
        self.tabBar.alpha = 0.9
        
        main.tabBarItem.image = UIImage(systemName: "house")
        main.tabBarItem.title = "Главная"
        second.tabBarItem.image = UIImage(systemName: "person")
        second.tabBarItem.title = "Аккаунт"
        
        self.viewControllers = [main, second]
    }
}
