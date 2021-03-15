//
//  UIViewController+Ex.swift
//  MyFavoriteForm
//
//  Created by Artur on 14.02.2021.
//

import UIKit

extension UIViewController {
    
    @objc public func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if let nextField = textField.superview?.viewWithTag(textField.tag + 1) as? UITextField {
            nextField.becomeFirstResponder()
        } else {
            textField.resignFirstResponder()
        }
        return true
    }
    
    func keyboardHideWhenTappedArround() {
        let tapGesture = UITapGestureRecognizer(target: self,
                                                action: #selector(self.dismissKeyboard))
        tapGesture.cancelsTouchesInView = true
        self.view.addGestureRecognizer(tapGesture)
    }
    @objc func dismissKeyboard() {
        self.view.endEditing(true)
    }
    
    func setBackgroundColor() {
        guard let bottomColor = UIColor(named: "BottomColor") else { return }
        guard let topColor = UIColor(named: "TopColor") else { return }
        let gradientLayer: CAGradientLayer = CAGradientLayer()
        gradientLayer.colors = [topColor.cgColor, bottomColor.cgColor]
        gradientLayer.frame = self.view.bounds
        self.view.layer.insertSublayer(gradientLayer, at: 0)
    }
}
