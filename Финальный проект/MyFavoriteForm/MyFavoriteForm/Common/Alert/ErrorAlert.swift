//
//  ErrorAlert.swift
//  MyFavoriteForm
//
//  Created by Artur on 07.03.2021.
//

import UIKit

class ErrorAlert {
    // MARK: - Static properties
    static let shared = ErrorAlert()
    
    // MARK: - Methods
    func error (message: String, viewController: UIViewController) {
        let alert = UIAlertController(title: "Упс!",
                                      message: message,
                                      preferredStyle: .alert)
        alert.addAction(
            UIAlertAction(
                title: "ОК",
                style: .cancel,
                handler: nil ))
        
        viewController.present(alert,
                                animated: true,
                                completion: nil)
    }
}
