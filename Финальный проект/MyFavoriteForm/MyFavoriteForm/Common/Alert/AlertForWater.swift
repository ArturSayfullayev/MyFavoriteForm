//
//  AlertForWater.swift
//  MyFavoriteForm
//
//  Created by Artur on 24.02.2021.
//

import UIKit

class Alert {
    // MARK: - Static properties
    static let shared = Alert()
    
    // MARK: - Methods
    func addWater(viewController: UIViewController) {
        let alert = UIAlertController(title: "Сколько вы выпили воды?(мл)",
                                      message: nil,
                                      preferredStyle: .alert)
        alert.addTextField { (text) in
            text.placeholder = "Введите количество"
            text.keyboardType = .numberPad
        }
        alert.addAction(
            UIAlertAction(
                title: "Добавить",
                style: .default,
                handler: { (action: UIAlertAction!) in
                    guard let textField = alert.textFields,
                          let text = textField[0].text else { return }
                    Logic.shared.setWater(water: text)
                    Logic.shared.writeValuesToFM()
                    viewController.viewWillAppear(false)
                }))
        alert.addAction(
            UIAlertAction(
                title: "Cancel",
                style: .cancel,
                handler: nil ))
        
        viewController.present(alert,
                                animated: true,
                                completion: nil)
    }
}
