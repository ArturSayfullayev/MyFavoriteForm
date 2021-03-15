//
//  Double+Ex.swift
//  MyFavoriteForm
//
//  Created by Artur on 24.02.2021.
//
import Foundation

extension Double {
    /// Преобразование числа в строку с 1 числом после точки
    func formatter() -> String {
        let divisor = pow(10.0, Double(1))
        return String(format: "%g", (self * divisor).rounded() / divisor)
    }
}
