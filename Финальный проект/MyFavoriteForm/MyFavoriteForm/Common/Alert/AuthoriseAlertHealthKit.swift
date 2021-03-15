//
//  AuthoriseAlertHealthKit.swift
//  MyFavoriteForm
//
//  Created by Artur on 12.03.2021.
//

import UIKit

class HeathKitAlert {
    // MARK: - Static properties
    static let shared = HeathKitAlert()
    
    // MARK: - Methods
    func alertHealthKit(viewController: UIViewController) {
        let alert = UIAlertController(title: nil,
                                      message: "Необходимо разрешить доступ для чтения показателей. Перейти на страницу управления доступом?",
                                      preferredStyle: .alert)
        alert.addAction(
            UIAlertAction(
                title: "OK",
                style: .default,
                handler: { (_) in
                    HealthKitSetupAssistant.authorizeHealthKit { (_, _) in
                            return
                    }
                }))
        
        alert.addAction(
            UIAlertAction(
                title: "Отмена",
                style: .destructive))
        
        viewController.present(alert,
                               animated: true,
                               completion: nil)
    }
}
