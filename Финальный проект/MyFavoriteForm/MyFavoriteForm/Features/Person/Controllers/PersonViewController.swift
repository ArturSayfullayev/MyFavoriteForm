//
//  PersonViewController.swift
//  MyFavoriteForm
//
//  Created by Artur on 19.02.2021.
//

import UIKit
import SnapKit

class PersonViewController: BasicScrollViewController {
    // MARK: - GUI Properties
    private lazy var mainView: MainPersonView = {
        let view = MainPersonView()
        view.setEditPersonClosure = { [weak self] in
            self?.setEditDonePerson(bool: false)
        }
        view.setDonePersonClosure = { [weak self] (profile) in
            self?.setEditDonePerson(bool: true)
            DefaultsManager.shared.writeDataToUDWithCodable(for: Logic.shared.userKey, model: profile)
            Logic.shared.setPersonValue()
 
            if view.setCustomEnergy() {
                view.getValueEnergy()
            } else {
                Logic.shared.setCalories(bool: true)
                Logic.shared.setWater(bool: true)
            }
            self?.setProfileValues()
        }
        return view
    }()
    
    // MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        self.mainScroll.addSubview(self.mainView)
        self.constraints()
        self.setBackgroundColor()
        self.setPropertiesForPickers()
        
        self.navigationItem.title = "Данные пользователя"
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.setProfileValues()
    }
    
    // MARK: - Constraints
    private func constraints() {
        self.mainView.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
            make.width.equalTo(self.mainScroll.snp.width)
            make.height.equalTo(self.mainScroll.snp.height).priority(750)
        }
    }
    
    // MARK: - Methods
    private func setPropertiesForPickers() {
        self.mainView.picker.delegate = self
        self.mainView.picker.dataSource = self
        
        self.mainView.sex.textField.delegate = self
        self.mainView.target.textField.delegate = self
        self.mainView.action.textField.delegate = self
    }
    private func setEditDonePerson(bool: Bool) {
        self.mainView.setEditDonePerson(bool: bool)
    }
    private func setProfileValues() {
        guard let person = Logic.shared.person else { return }
        self.mainView.setPersonValue(person: person)
    }
}

extension PersonViewController: UIPickerViewDataSource, UIPickerViewDelegate, UITextFieldDelegate {
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        self.mainView.picker.tag = textField.tag
        self.mainView.picker.reloadAllComponents()
        
        return true
    }
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        1
    }
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        switch pickerView.tag {
        case 4:
            return Profile.Sex.allCases.count
        case 5:
            return Profile.Target.allCases.count
        case 6:
            return Profile.Action.allCases.count
        default:
            return 0
        }
    }
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        switch pickerView.tag {
        case 4:
            return Profile.Sex.allCases[row].rawValue
        case 5:
            return Profile.Target.allCases[row].rawValue
        case 6:
            return Profile.Action.allCases[row].rawValue
        default:
            return nil
        }
    }
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        switch pickerView.tag {
        case 4:
            self.mainView.sex.textField.text = Profile.Sex.allCases[row].rawValue
        case 5:
            self.mainView.target.textField.text = Profile.Target.allCases[row].rawValue
        case 6:
            self.mainView.action.textField.text = Profile.Action.allCases[row].rawValue
        default:
            break
        }
    }
}
