//
//  MainViewAddProduct.swift
//  MyFavoriteForm
//
//  Created by Artur on 23.02.2021.
//

import UIKit
import SnapKit

class MainViewAddProduct: UIView {
    // MARK: - Closure
    var closeActionClosure: (() -> Void)?
    var addNewProductClosure: (() -> Void)?
    
    // MARK: - Properties
    private let edgeInsets = UIEdgeInsets(top: 50, left: 30, bottom: 0, right: 30)
    
    // MARK: - GUI Properties
    private lazy var closeButton: UIButton = {
        let button = UIButton(type: .close)
        button.addTarget(self,
                         action: #selector(self.closeAction),
                         for: .touchUpInside)
        return button
    }()
    
    private lazy var mainInfoLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 30)
        label.textAlignment = .center
        label.text = "Добавдение продукта"
        
        return label
    }()
    private lazy var additionalInfoLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 2
        label.textAlignment = .center
        label.text = "Энергитическая ценность на 100 гр. продукта:"
        return label
    }()
    
    private lazy var makeName: BasicViewOneStack = {
        let name = BasicViewOneStack()
        name.setLabelText(text: "Название:")
        return name
    }()
    private lazy var makeCalories: BasicViewOneStack = {
        let calories = BasicViewOneStack()
        calories.setLabelText(text: "Общая калорийность на 100 гр. продукта:")
        calories.setNumPad(keyboardType: .numberPad)
        return calories
    }()
    private lazy var makePFC: BasicViewThreeStack = {
        let pfc = BasicViewThreeStack()
        return pfc
    }()
    private lazy var addButton: UIButton = {
        let button = UIButton()
        button.setTitle("Добавить", for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 27)
        button.setTitleColor(.black, for: .normal)
        button.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMaxYCorner]
        button.layer.cornerRadius = 20
        button.layer.shadowOpacity = 0.4
        button.backgroundColor = .green
        button.addTarget(self,
                         action: #selector(self.addNewProduct),
                         for: .touchUpInside)
        
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
        self.addSubviews([self.closeButton,
                          self.mainInfoLabel,
                          self.makeName,
                          self.additionalInfoLabel,
                          self.makePFC,
                          self.makeCalories,
                          self.addButton])
   
        self.constraints()
    }
    
    // MARK: - Methods
    @objc private func closeAction() {
        self.closeActionClosure?()
    }
    @objc private func addNewProduct() {
        self.addNewProductClosure?()
    }
    
    func getValuesForNewProduct() -> FoodModelFromFileManager.Menu? {
        let tuple = self.makePFC.getValuesFromTextField()
        guard let name = self.makeName.getTextFromTextField(),
              let protein = tuple.protein,
              let fats = tuple.fats,
              let carbohydrates = tuple.carbohydrates,
              let calories = self.makeCalories.getTextFromTextField() else { return nil }
        return FoodModelFromFileManager.Menu(name: name,
                                             proteins: protein,
                                             fats: fats,
                                             carbohydrates: carbohydrates,
                                             calories: calories)
    }
    
    // MARK: - Constraints
    private func constraints() {
        self.closeButton.snp.makeConstraints { (make) in
            make.top.left.equalToSuperview().inset(10)
            make.height.width.equalTo(30)
        }
        self.mainInfoLabel.snp.makeConstraints { (make) in
            make.top.left.right.equalToSuperview().inset(self.edgeInsets)
        }
        self.makeName.snp.makeConstraints { (make) in
            make.top.equalTo(self.mainInfoLabel.snp.bottom).offset(40)
            make.left.right.equalToSuperview().inset(self.edgeInsets)
        }
        self.additionalInfoLabel.snp.makeConstraints { (make) in
            make.top.equalTo(self.makeName.snp.bottom).offset(40)
            make.left.right.equalToSuperview().inset(self.edgeInsets)
        }
        self.makePFC.snp.makeConstraints { (make) in
            make.top.equalTo(self.additionalInfoLabel.snp.bottom).offset(30)
            make.left.right.equalToSuperview().inset(self.edgeInsets)
        }
        self.makeCalories.snp.makeConstraints { (make) in
            make.top.equalTo(self.makePFC.snp.bottom).offset(40)
            make.left.right.equalToSuperview().inset(self.edgeInsets)
        }
        self.addButton.snp.makeConstraints { (make) in
            make.top.equalTo(self.makeCalories.snp.bottom).offset(100)
            make.left.right.equalToSuperview().inset(self.edgeInsets)
            make.height.equalTo(70)
        }
    }
}
