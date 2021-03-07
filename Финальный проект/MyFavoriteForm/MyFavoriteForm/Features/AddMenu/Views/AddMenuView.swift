//
//  AddMenuView.swift
//  MyFavoriteForm
//
//  Created by Artur on 21.02.2021.
//

import UIKit
import SnapKit

class AddMenuView: UIView {
    // MARK: - Closure
    var editValuesClosure: (() -> Void)?
    var addButtonClosure: (() -> Void)?
    
    // MARK: - Properties
    private let edgeInsets = UIEdgeInsets(top: 40, left: 30, bottom: 0, right: 30)
    
    // MARK: - GUI Properties
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 1
        label.text = "Добавление блюда"
        label.font = UIFont.boldSystemFont(ofSize: 25)
        label.textAlignment = .center
        
        return label
    }()
    
    private lazy var mainLabel: BasicMainLabel = {
        let label = BasicMainLabel()
        
        return label
    }()
    private lazy var additionalLabel: UILabel = {
        let label = UILabel()
        label.text = "Количество(гр):"
        label.font = UIFont.systemFont(ofSize: 25)
        
        return label
    }()
    
    private lazy var textField: UITextField = {
        let textField = UITextField()
        textField.backgroundColor = .white
        textField.layer.cornerRadius = 8
        textField.clearButtonMode = .whileEditing
        textField.keyboardType = .numberPad
        textField.addTarget(self,
                            action: #selector(self.setEditedValues),
                            for: .editingChanged)
        
        return textField
    }()
    
    private lazy var addButton: UIButton = {
        let button = UIButton()
        button.setTitle("Добавить", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 27)
        button.backgroundColor = UIColor(named: "ButtonEnter")
        button.layer.maskedCorners = [.layerMaxXMinYCorner, .layerMinXMaxYCorner]
        button.layer.cornerRadius = 20
        button.layer.shadowOpacity = 0.4
        button.addTarget(self,
                         action: #selector(self.addProductAction),
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
        self.addSubviews([self.titleLabel,
                          self.mainLabel,
                          self.additionalLabel,
                          self.textField,
                          self.addButton])
        self.constraints()
        
    }
    
    // MARK: - Methods
    @objc private func addProductAction() {
        self.addButtonClosure?()
    }
    
    @objc private func setEditedValues() {
        self.editValuesClosure?()
    }
    
    func setTextFromTextField() -> String? {
        self.textField.text
    }
    
    func setLableMenu(menu: FoodModelFromFileManager.Menu) {
        self.mainLabel.setValues(name: menu.name,
                                 proteins: menu.proteins,
                                 fats: menu.fats,
                                 carbohydrates: menu.carbohydrates,
                                 calories: menu.calories)
    }
    
    // MARK: - Constraints
    private func constraints() {
        self.titleLabel.snp.makeConstraints { (make) in
            make.top.left.right.equalToSuperview().inset(self.edgeInsets)
        }
        self.mainLabel.snp.makeConstraints { (make) in
            make.top.equalTo(self.titleLabel.snp.bottom).offset(30)
            make.left.right.equalToSuperview().inset(self.edgeInsets)
        }
        self.additionalLabel.snp.makeConstraints { (make) in
            make.top.equalTo(self.mainLabel.snp.bottom).offset(30)
            make.left.equalToSuperview().inset(self.edgeInsets)
        }
        self.textField.snp.makeConstraints { (make) in
            make.left.greaterThanOrEqualTo(self.additionalLabel.snp.right).offset(30)
            make.right.equalToSuperview().inset(self.edgeInsets)
            make.centerY.equalTo(self.additionalLabel.snp.centerY)
            make.height.equalTo(self.additionalLabel.snp.height)
            make.width.equalTo(100)
        }
        self.addButton.snp.makeConstraints { (make) in
            make.top.equalTo(self.additionalLabel).offset(100)
            make.left.right.equalToSuperview().inset(self.edgeInsets)
            make.height.equalTo(70)
        }
    }
}
