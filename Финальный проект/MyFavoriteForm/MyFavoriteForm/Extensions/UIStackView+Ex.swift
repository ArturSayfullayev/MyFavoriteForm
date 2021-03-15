//
//  UIStackView+Ex.swift
//  MyFavoriteForm
//
//  Created by Artur on 14.02.2021.
//

import UIKit

extension UIStackView {
    /// Добавление несколько вью в стек
    func addArrangedSubviews(_ views: [UIView]) {
        views.forEach {
            self.addArrangedSubview($0)
        }
    }
}
