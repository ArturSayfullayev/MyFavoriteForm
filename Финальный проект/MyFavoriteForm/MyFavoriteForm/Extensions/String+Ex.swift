//
//  String+Ex.swift
//  MyFavoriteForm
//
//  Created by Artur on 13.03.2021.
//

import UIKit

extension String {
    func swapSymbol() -> String {
        self.replacingOccurrences(of: ",", with: ".")
    }
}
