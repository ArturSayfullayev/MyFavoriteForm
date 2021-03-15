//
//  MainPersonView.swift
//  MyFavoriteForm
//
//  Created by Artur on 21.02.2021.
//

import UIKit
import SnapKit

class MainPersonView: UIView {
    // MARK: Properties
    private let edgeInsets = UIEdgeInsets(all: 12)
    private let buttonInsets = UIEdgeInsets(all: 20)
    private let containerInsets = UIEdgeInsets(all: 30)
    private let heightFloat: Float = 25
    private let width: Float = 150
    private let myOffset: Float = 20
    
    var setEditPersonClosure: (() -> Void)?
    var setDonePersonClosure: ((Profile) -> Void)?
    
    // MARK: - GUI Properties
    private(set) lazy var picker = UIPickerView()
    
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
    private var mainContainerView: UIView = {
        let view = UIView()
        view.layer.cornerRadius = 10
        view.layer.borderWidth = 1
        view.backgroundColor = UIColor(named: "BackgroundColorOpacity")
        return view
    }()
    private var containerViewForTopStack: UIView = {
        let view = UIView()
        view.layer.cornerRadius = 10
        view.layer.borderWidth = 1
        view.backgroundColor = UIColor(named: "BackgroundColorOpacity")
        return view
    }()
    private var containerViewForBottomStack: UIView = {
        let view = UIView()
        view.layer.cornerRadius = 10
        view.layer.borderWidth = 1
        view.backgroundColor = UIColor(named: "BackgroundColorOpacity")
        return view
    }()
    private lazy var infoLabel: UILabel = {
        let label = UILabel()
        label.text = "Данные пользователя"
        label.font = UIFont.boldSystemFont(ofSize: 30)
        label.textAlignment = .center
        
        return label
    }()
    private lazy var additionalInfoLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.text = "Дневные нормы питательных веществ:"
        label.font = UIFont.boldSystemFont(ofSize: 17)
        
        return label
    }()
    private(set) lazy var editButton: UIButton = {
        let button = UIButton()
        button.layer.borderWidth = 1
        button.layer.cornerRadius = 10
        button.setTitle("Редактировать", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.addTarget(self, action: #selector(self.actionEditPerson), for: .touchUpInside)
        
        return button
    }()
    private lazy var doneButton: UIButton = {
        let button = UIButton()
        button.layer.borderWidth = 1
        button.layer.cornerRadius = 10
        button.backgroundColor = UIColor(named: "BackgroundColorOpacity")
        button.setTitle("Сохранить", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.addTarget(self, action: #selector(self.actionDonePerson), for: .touchUpInside)
        button.isHidden = true
        
        return button
    }()
    private lazy var mainStack: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.distribution = .fillEqually
        stack.spacing = 30
        
        return stack
    }()
    private lazy var topStack: UIStackView = {
        let stack = UIStackView()
        stack.axis = .horizontal
        stack.distribution = .fillEqually
        stack.spacing = 25
        
        return stack
    }()
    private lazy var bottomStack: UIStackView = {
        let stack = UIStackView()
        stack.axis = .horizontal
        stack.distribution = .fillEqually
        stack.spacing = 30
        
        return stack
    }()
    private(set) lazy var name: BasicPersonView = {
        let name = BasicPersonView()
        name.setTitle(text: "Имя")
        name.textField.tag = 0
        
        return name
    }()
    private(set) lazy var age: BasicPersonView = {
        let age = BasicPersonView()
        age.textField.inputView = self.datePicker
        age.setTitle(text: "Дата рождения")
        age.textField.tag = 1
        
        return age
    }()
    private(set) lazy var height: BasicPersonView = {
        let height = BasicPersonView()
        height.setTitle(text: "Рост")
        height.textField.tag = 2
        
        return height
    }()
    private(set) lazy var weight: BasicPersonView = {
        let weight = BasicPersonView()
        weight.setTitle(text: "Вес")
        weight.textField.tag = 3
        
        return weight
    }()
    private(set) lazy var sex: BasicPersonView = {
        let sex = BasicPersonView()
        sex.textField.inputView = self.picker
        sex.setTitle(text: "Пол")
        sex.textField.tag = 4
        
        return sex
    }()
    private(set) lazy var target: BasicPersonView = {
        let target = BasicPersonView()
        target.textField.inputView = self.picker
        target.setTitle(text: "Цель")
        target.textField.tag = 5
        
        return target
    }()
    private(set) lazy var action: BasicPersonView = {
        let action = BasicPersonView()
        action.textField.inputView = self.picker
        action.setTitle(text: "Активность")
        action.textField.tag = 6
        
        return action
    }()
    
    private lazy var protein: BasicPersonEnergyView = {
        let protein = BasicPersonEnergyView()
        protein.setTitle(title: "Белки")
        
        return protein
    }()
    private lazy var fats: BasicPersonEnergyView = {
        let fats = BasicPersonEnergyView()
        fats.setTitle(title: "Жиры")
        
        return fats
    }()
    private lazy var carbohydrates: BasicPersonEnergyView = {
        let carbohydrates = BasicPersonEnergyView()
        carbohydrates.setTitle(title: "Углеводы")
        
        return carbohydrates
    }()
    private lazy var calories: BasicPersonEnergyView = {
        let calories = BasicPersonEnergyView()
        calories.setTitle(title: "Калории")
        
        return calories
    }()
    private lazy var water: BasicPersonEnergyView = {
        let water = BasicPersonEnergyView()
        water.setTitle(title: "Вода")
        
        return water
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
        self.addSubviews([self.doneButton,
                          self.editButton,
                          self.additionalInfoLabel,
                          self.mainContainerView,
                          self.containerViewForTopStack,
                          self.containerViewForBottomStack])

        self.mainContainerView.addSubview(self.mainStack)
        self.containerViewForTopStack.addSubview(self.topStack)
        self.containerViewForBottomStack.addSubview(self.bottomStack)
        self.mainStack.addArrangedSubviews([self.name,
                                            self.age,
                                            self.height,
                                            self.weight,
                                            self.sex,
                                            self.target,
                                            self.action])
        self.topStack.addArrangedSubviews([self.protein,
                                           self.fats,
                                           self.carbohydrates])
        self.bottomStack.addArrangedSubviews([self.calories,
                                              self.water])
        self.constraints()
    }
    
    // MARK: - Constraints
    private func constraints() {
        self.editButton.snp.makeConstraints { (make) in
            make.top.equalToSuperview().offset(self.myOffset)
            make.right.equalToSuperview().inset(self.buttonInsets)
            make.height.equalTo(self.heightFloat)
            make.width.equalTo(self.width)
        }
        self.doneButton.snp.makeConstraints { (make) in
            make.top.equalToSuperview().offset(self.myOffset)
            make.right.equalToSuperview().inset(self.buttonInsets)
            make.height.equalTo(self.heightFloat)
            make.width.equalTo(self.width)
        }
        self.mainContainerView.snp.updateConstraints { (make) in
            make.top.equalTo(self.doneButton.snp.bottom).offset(self.myOffset)
            make.left.right.equalToSuperview().inset(self.containerInsets)
        }
        self.mainStack.snp.updateConstraints { (make) in
            make.edges.equalToSuperview().inset(self.edgeInsets)
        }
        self.additionalInfoLabel.snp.makeConstraints { (make) in
            make.top.equalTo(self.mainContainerView.snp.bottom).offset(self.myOffset)
            make.left.right.equalToSuperview().inset(self.containerInsets)
            make.height.equalTo(self.heightFloat)
        }
        self.containerViewForTopStack.snp.updateConstraints { (make) in
            make.top.equalTo(self.additionalInfoLabel.snp.bottom).offset(10)
            make.left.right.equalToSuperview().inset(self.containerInsets)
        }
        self.topStack.snp.updateConstraints { (make) in
            make.edges.equalToSuperview().inset(self.edgeInsets)
        }
        self.containerViewForBottomStack.snp.updateConstraints { (make) in
            make.top.equalTo(self.containerViewForTopStack.snp.bottom).offset(30)
            make.left.right.bottom.equalToSuperview().inset(self.containerInsets)
        }
        self.bottomStack.snp.updateConstraints { (make) in
            make.edges.equalToSuperview().inset(self.edgeInsets)
        }
    }
    
    // MARK: - Methods
    @objc private func dateFromDatePicker() {
        let formatter = DateFormatter()
        formatter.dateFormat = Logic.shared.formateDateDMY
        self.age.textField.text = formatter.string(from: self.datePicker.date)
    }
    @objc private func actionEditPerson() {
        self.setEditPersonClosure?()
    }
    @objc private func actionDonePerson() {
        self.setDateToDatePicker()
        
        guard let name = self.name.textField.text,
              let age = Calendar.current.dateComponents([.year], from: self.datePicker.date, to: Date()).year,
              let height = self.height.textField.text,
              let weight = self.weight.textField.text,
              let sex = self.sex.textField.text,
              let target = self.target.textField.text,
              let action = self.action.textField.text,
              let dateOfBirthday = self.age.textField.text else { return }
    
        let profile = Profile(name: name,
                              age: String(age),
                              height: height,
                              weight: weight,
                              sex: Profile.Sex(rawValue: sex) ?? Profile.Sex.female,
                              target: Profile.Target(rawValue: target) ?? Profile.Target.maintaining,
                              action: Profile.Action(rawValue: action) ?? Profile.Action.b,
                              dateOfBirthday: dateOfBirthday)
        self.setDonePersonClosure?(profile)
    }
    private func setDateToDatePicker() {
        let formatter = DateFormatter()
        formatter.dateFormat = Logic.shared.formateDateDMY
        guard let dateOfBirthday = self.age.textField.text,
              let date = formatter.date(from: dateOfBirthday) else { return }
        self.datePicker.date = date
    }
    func getValueEnergy() {
        guard let calories = self.calories.textField.text,
              let protein = self.protein.textField.text,
              let fats = self.fats.textField.text,
              let carbohydrates = self.carbohydrates.textField.text,
              let water = self.water.textField.text else { return }
        
        Logic.shared.setCalories(bool: false, properties: Logic.AllProperties(
                                    calories: Double(calories) ?? 0,
                                    proteins: Double(protein) ?? 0,
                                    fats: Double(fats) ?? 0,
                                    carbohydrates: Double(carbohydrates) ?? 0))
        Logic.shared.setWater(bool: false, water: water)
    }
    
    func setCustomEnergy() -> Bool {
        guard let calories = self.calories.textField.text,
              let protein = self.protein.textField.text,
              let fats = self.fats.textField.text,
              let carbohydrates = self.carbohydrates.textField.text,
              let water = self.water.textField.text else { return false }
        
        let oldCalories: String = Logic.shared.getCalories()
        let oldProteins = Logic.shared.getProteins()
        let oldFats = Logic.shared.getFats()
        let oldCarbohydrates = Logic.shared.getCarbohydrates()
        let oldWater = Logic.shared.getWater()
        
        if calories != oldCalories ||
            protein != oldProteins ||
            fats != oldFats ||
            carbohydrates != oldCarbohydrates ||
            water != oldWater {
            return true
        }
        return false
    }
    
    func setEditDonePerson(bool: Bool) {
        if bool {
        self.name.setEdit(bool: true)
        self.age.setEdit(bool: true)
        self.height.setEdit(bool: true)
        self.weight.setEdit(bool: true)
        self.sex.setEdit(bool: true)
        self.target.setEdit(bool: true)
        self.action.setEdit(bool: true)
        
        self.protein.setEdit(bool: true)
        self.fats.setEdit(bool: true)
        self.carbohydrates.setEdit(bool: true)
        self.calories.setEdit(bool: true)
        self.water.setEdit(bool: true)
         
        self.editButton.isHidden = false
        self.doneButton.isHidden = true
        } else {
            self.name.setEdit(bool: false)
            self.age.setEdit(bool: false)
            self.height.setEdit(bool: false)
            self.weight.setEdit(bool: false)
            self.sex.setEdit(bool: false)
            self.target.setEdit(bool: false)
            self.action.setEdit(bool: false)
            
            self.protein.setEdit(bool: false)
            self.fats.setEdit(bool: false)
            self.carbohydrates.setEdit(bool: false)
            self.calories.setEdit(bool: false)
            self.water.setEdit(bool: false)
             
            self.editButton.isHidden = true
            self.doneButton.isHidden = false
        }
    }
    
    // MARK: - Setter
    func setPersonValue(person: Profile) {
        self.name.setValues(text: person.name)
        self.age.setValues(text: person.dateOfBirthday)
        self.height.setValues(text: person.height)
        self.weight.setValues(text: person.weight)
        self.sex.setValues(text: person.sex.rawValue)
        self.target.setValues(text: person.target.rawValue)
        self.action.setValues(text: person.action.rawValue)
        
        self.protein.setValue(value: Logic.shared.getProteins())
        self.fats.setValue(value: Logic.shared.getFats())
        self.carbohydrates.setValue(value: Logic.shared.getCarbohydrates())
        self.calories.setValue(value: Logic.shared.getCalories())
        self.water.setValue(value: Logic.shared.getWater())
    }
}
