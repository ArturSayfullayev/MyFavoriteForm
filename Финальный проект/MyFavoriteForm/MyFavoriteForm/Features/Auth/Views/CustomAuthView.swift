//
//  CustomAuthView.swift
//  MyFavoriteForm
//
//  Created by Artur on 16.02.2021.
//

import UIKit

class CustomAuthView: UIView {
    // MARK: - Closure
    var buttonAction: ((Profile) -> Void)?
    
    // MARK: - GUI Properties
    private lazy var infoLabel: UILabel = {
        let label = UILabel()
        label.text = "Авторизация"
        label.font = UIFont.boldSystemFont(ofSize: 30)
        label.textAlignment = .center
        return label
    }()
    
    private lazy var stack: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.spacing = 30
        stack.distribution = .fillEqually
        return stack
    }()
    
    private(set) lazy var name: BasicView = {
        let name = BasicView()
        name.setTitle(with: "Имя")
        name.textField.clearButtonMode = .whileEditing
        name.textField.tag = 0
        return name
    }()
    
    private(set) lazy var age: BasicView = {
        let age = BasicView()
        age.textField.inputView = self.datePicker
        age.setTitle(with: "Дата рождения")
        age.textField.tag = 1
        return age
    }()
    
    private(set) lazy var height: BasicView = {
        let height = BasicView()
        height.setKeyboardType(type: .numberPad)
        height.setTitle(with: "Рост(см)")
        height.textField.clearButtonMode = .whileEditing
        height.textField.tag = 2
        return height
    }()
    
    private(set) lazy var weight: BasicView = {
        let weight = BasicView()
        weight.setKeyboardType(type: .numberPad)
        weight.setTitle(with: "Вес(кг)")
        weight.textField.clearButtonMode = .whileEditing
        weight.textField.tag = 3
        return weight
    }()
    
    private(set) lazy var sex: BasicView = {
        let sex = BasicView()
        sex.textField.inputView = self.picker
        sex.setTitle(with: "Пол")
        sex.textField.tag = 4
        return sex
    }()
    
    private(set) lazy var target: BasicView = {
        let target = BasicView()
        target.textField.inputView = self.picker
        target.setTitle(with: "Цель")
        target.textField.tag = 5
        return target
    }()
    
    private(set) lazy var action: BasicView = {
        let action = BasicView()
        action.textField.inputView = self.picker
        action.setTitle(with: "Активность")
        action.textField.tag = 6
        return action
    }()
    
    private lazy var buttonAuth: UIButton = {
        let button = UIButton()
        button.setTitle("Войти", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 27)
        button.backgroundColor = UIColor(named: "ButtonEnter")
        button.layer.maskedCorners = [.layerMaxXMinYCorner, .layerMinXMaxYCorner]
        button.layer.cornerRadius = 24
        button.layer.shadowColor = UIColor.black.cgColor
        button.layer.shadowRadius = 16
        button.layer.shadowOpacity = 0.6
        button.addTarget(self,
                         action: #selector(self.moveActionButton),
                         for: .touchUpInside)
        return button
    }()
    
    private(set) lazy var datePicker: UIDatePicker = {
        let picker = UIDatePicker()
        picker.preferredDatePickerStyle = .wheels
        picker.datePickerMode = .date
        if let localID = Locale.preferredLanguages.first {
            picker.locale = Locale(identifier: localID)}
        picker.addTarget(self,
                         action: #selector(self.dateFromDatePicker),
                         for: .valueChanged)
        return picker
    }()
    
    private(set) lazy var picker = UIPickerView()
    
    // MARK: - Inizialization
    override init (frame: CGRect) {
        super.init(frame: frame)
        
        self.initView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func initView() {
        self.addSubviews([self.infoLabel,
                          self.stack,
                          self.buttonAuth])
        
        self.stack.addArrangedSubviews([self.name,
                                        self.age,
                                        self.height,
                                        self.weight,
                                        self.sex,
                                        self.target,
                                        self.action]) 
        self.constraints()
    }
    
    // MARK: - Constraints
    private func constraints() {
        self.infoLabel.snp.updateConstraints { (make) in
            make.top.left.right.equalToSuperview().inset(40)
            make.height.equalTo(30)
        }
        self.stack.snp.updateConstraints { (make) in
            make.top.equalTo(self.infoLabel.snp.bottom).offset(40)
            make.left.right.equalToSuperview().inset(30)
        }
        self.buttonAuth.snp.updateConstraints { (make) in
            make.top.greaterThanOrEqualTo(self.stack.snp.bottom).offset(20)
            make.left.right.equalToSuperview().inset(70)
            make.bottom.greaterThanOrEqualToSuperview().offset(-130)
            make.height.equalTo(70)
        }
    }
    // MARK: - Methods
    @objc private func dateFromDatePicker() {
        self.age.textField.text = self.datePicker.date.formatter()
    }
    @objc private func moveActionButton() {
        guard let age = Calendar.current.dateComponents([.year], from: self.datePicker.date, to: Date()).year,
              let name = self.name.textField.text,
              let height = self.height.textField.text,
              let weight = self.weight.textField.text,
              let sex = self.sex.textField.text,
              let target = self.target.textField.text,
              let action = self.action.textField.text,
              let dateOfBirthday = self.age.textField.text else { return }
        
        let person = Profile(name: name,
                             age: String(age),
                             height: height,
                             weight: weight,
                             sex: Profile.Sex(rawValue: sex) ?? Profile.Sex.female,
                             target: Profile.Target(rawValue: target) ?? Profile.Target.maintaining,
                             action: Profile.Action(rawValue: action) ?? Profile.Action.b,
                             dateOfBirthday: dateOfBirthday)
        self.buttonAction?(person)
    }
}
