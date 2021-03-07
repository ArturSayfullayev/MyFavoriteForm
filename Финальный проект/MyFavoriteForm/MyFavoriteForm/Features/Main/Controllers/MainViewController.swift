//
//  MainViewController.swift
//  MyFavoriteForm
//
//  Created by Artur on 17.02.2021.
//

import UIKit
import SnapKit

class MainViewController: UIViewController {
    // MARK: - GUI Properties
    private lazy var mainView = WaterTripleBars()
    private(set) lazy var secondView: MainViewWaterAndButtons = {
        let view = MainViewWaterAndButtons()
        view.closureAction = { [weak self] in
            self?.moveNextVC()
        }
        view.addWaterAction = { [weak self] in
            self?.addAlertWater()
        }
        
        return view
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        Logic.shared.setCalories(bool: true)
        Logic.shared.setWater(bool: true)
        Logic.shared.setCurentValuesFromFM()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.secondView.setValuesWaterBar()
        
        self.navigationController?.setNavigationBarHidden(true, animated: false)
        
        for i in view.subviews {
            i.removeFromSuperview()
        }
        
        self.mainView = WaterTripleBars(frame: CGRect(x: 0,
                                                     y: 0,
                                                     width: self.view.bounds.width / 2,
                                                     height: self.view.bounds.width / 2))
        self.view.addSubviews([self.mainView,
                               self.secondView])
        self.setBackgroundColor()
        self.setConstraints()
    }
    
    private func setConstraints() {
        self.mainView.snp.updateConstraints { (make) in
            make.top.equalToSuperview().inset(100)
            make.left.equalToSuperview().offset((self.view.bounds.width / 2) / 2)
        }
        self.secondView.snp.makeConstraints { (make) in
            make.top.equalToSuperview().offset(self.view.bounds.width / 2 + 180)
            make.left.right.bottom.equalToSuperview()
        }
    }

    private func moveNextVC() {
                let vc = SearchMenuViewController()
                self.navigationController?.pushViewController(vc, animated: true)
    }
    private func addAlertWater() {
        Alert.shared.addWater(viewController: self)
    }
}
