//
//  UIView+Ex.swift
//  MyFavoriteForm
//
//  Created by Artur on 14.02.2021.
//

import UIKit

extension UIView {
    /// Добавление несколько вью одним методом
    func addSubviews(_ views: [UIView]) {
        views.forEach {
            self.addSubview($0)
        }
    }
}
