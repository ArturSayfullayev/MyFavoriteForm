//
//  Date+Ex.swift
//  MyFavoriteForm
//
//  Created by Artur on 06.03.2021.
//

import Foundation

extension Date {
    func formatter() -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = Logic.shared.formateDateDMY
        return formatter.string(from: self)
    }
}
