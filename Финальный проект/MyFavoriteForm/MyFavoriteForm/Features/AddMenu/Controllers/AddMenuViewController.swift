//
//  AddMenuViewController.swift
//  MyFavoriteForm
//
//  Created by Artur on 21.02.2021.
//

import UIKit
import SnapKit

class AddMenuViewController: BasicScrollViewController {
    // MARK: - GUI Properties
    private(set) lazy var mainView: AddMenuView = {
        let view = AddMenuView()
        view.editValuesClosure = { [ weak self ] in
            guard let self = self,
                  let mass = self.mainView.setTextFromTextField(),
                  let presentMenu = Logic.shared.presentEnergy(mass: mass) else { return }
            
            self.mainView.setLableMenu(
                menu: FoodModelFromFileManager.Menu(name: presentMenu.name,
                                                    proteins: presentMenu.proteins,
                                                    fats: presentMenu.fats,
                                                    carbohydrates: presentMenu.carbohydrates,
                                                    calories: presentMenu.calories))
        }
        view.addButtonClosure = { [ weak self ] in
            guard let self = self,
                  let mass = self.mainView.setTextFromTextField() else { return }
            if mass == "" {
                ErrorAlert.shared.error(message: "Введите массу блюда!", viewController: self)
            } else {
                Logic.shared.setEnergyFromFood(mass: mass)
                self.navigationController?.popToRootViewController(animated: true)
            }
        }
        return view
    }()
    
    // MARK: - LifeCycle
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
