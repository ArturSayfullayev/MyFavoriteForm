//
//  MainViewWaterAndButtons.swift
//  MyFavoriteForm
//
//  Created by Artur on 19.02.2021.
//

import UIKit
import SnapKit

class MainViewWaterAndButtons: UIView {
    // MARK: - Closures
    var closureAction: (() -> Void)?
    var addWaterAction: (() -> Void)?
    
    // MARK: - GUI Properties
    private lazy var waterProgress = WaterProgressLabel()
    
    private lazy var date: UILabel = {
        let date = UILabel()
        date.text = Date().formatter()
        
        return date
    }()
    
    private lazy var customButton: UIButton = {
        let button = CustomButton()
        button.setLabel(title: "Добавить прием пищи")
        button.setImage(image: "food")
        button.addTarget(self, action: #selector(self.moveNextVC), for: .touchUpInside)

        return button
    }()
    
    private lazy var customButtonWater: UIButton = {
        let button = CustomButton()
        button.setLabel(title: "Добавить воду")
        button.setImage(image: "water")
        button.addTarget(self, action: #selector(self.addWater), for: .touchUpInside)
        
        return button
    }()
    
    // MARK: - Inizialization
    override init (frame: CGRect) {
        super.init(frame: frame)
        
        self.initView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func initView() {
        self.addSubviews([self.waterProgress,
                          self.date,
                          self.customButton,
                          self.customButtonWater])
        
        self.constraints()
        
    }
    private func constraints() {
        self.waterProgress.snp.updateConstraints { (make) in
            make.top.left.right.equalToSuperview()
        }
        self.date.snp.updateConstraints { (make) in
            make.top.equalTo(self.waterProgress.snp.bottom).offset(20)
            make.centerX.equalToSuperview()
        }
        self.customButton.snp.updateConstraints { (make) in
            make.top.equalTo(self.date.snp.bottom).offset(50)
            make.left.right.equalToSuperview().inset(30)
        }
        self.customButtonWater.snp.updateConstraints { (make) in
            make.top.equalTo(self.customButton.snp.bottom).offset(40)
            make.left.right.equalToSuperview().inset(30)
        }
    }
    
    // MARK: - Methods
    @objc func moveNextVC() {
        self.closureAction?()
    }
    @objc func addWater() {
        self.addWaterAction?()
    }
    
    func setValuesWaterBar() {
        self.waterProgress.setTextWaterBar(text: "Вода(мл): \(Logic.shared.getCurrentWater())/\(Logic.shared.getWater())")
        self.waterProgress.waterProgress.setProgress(value: Logic.shared.getPercentWater())
    }
}
