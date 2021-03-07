//
//  AddProductViewController.swift
//  MyFavoriteForm
//
//  Created by Artur on 23.02.2021.
//

import UIKit
import SnapKit

class AddProductViewController: BasicScrollViewController {
    // MARK: - GUI Properties
    private lazy var mainView: MainViewAddProduct = {
        let mainView = MainViewAddProduct()
        mainView.closeActionClosure = { [ weak self ] in
            self?.dismiss(animated: true)
        }
        
        mainView.addNewProductClosure = { [ weak self ] in
            guard let self = self,
                  let menu = self.mainView.getValuesForNewProduct() else { return }
            if menu.name == "" ||
                menu.proteins == "" ||
                menu.fats == "" ||
                menu.carbohydrates == "" ||
                menu.calories == "" {
                ErrorAlert.shared.error(message: "Заполниите все поля!", viewController: self)
            } else {
                NotificationCenter.default.post(name: .productName,
                                                object: nil,
                                                userInfo: ["product": menu])
                self.dismiss(animated: true)
            }
        }
        return mainView
    }()
    
    // MARK: - LifeCYcle
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setBackgroundColor()
        self.mainScroll.addSubview(self.mainView)
        self.constraints()
    }
    // MARK: - Constraints
    private func constraints() {
        self.mainView.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
            make.width.equalTo(self.mainScroll.snp.width)
            make.height.equalTo(self.mainScroll.snp.height).priority(750)
        }
    }
}
