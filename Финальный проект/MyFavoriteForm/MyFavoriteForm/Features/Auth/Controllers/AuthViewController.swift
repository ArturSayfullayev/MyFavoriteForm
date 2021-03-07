//
//  AuthViewController.swift
//  MyFavoriteForm
//
//  Created by Artur on 14.02.2021.
//

import UIKit
import SnapKit

class AuthViewController: BasicScrollViewController {
    // MARK: - GUI Properties
    private lazy var authView: CustomAuthView = {
        let view = CustomAuthView()
        view.buttonAction = { [weak self] (profile) in
            guard let self = self else { return }
            if profile.name == "" ||
                profile.dateOfBirthday == "" ||
                profile.height == "" ||
                profile.weight == "" {
                ErrorAlert.shared.error(message: "Заполните все поля!", viewController: self)
            } else {
                DefaultsManager.shared.writeDataToUDWithCodable(for: Logic.shared.userKey, model: profile)
                Logic.shared.setPersonValue()
                self.moveMainViewController()
            }
        }
        return view
    }()

    //MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.setNavigationBarHidden(true, animated: false)
        self.setBackgroundColor()
     
        self.mainScroll.addSubview(self.authView)
       
        self.constraits()
        self.setPropertiesForPickers()
    }
    
    // MARK: - Methods
    private func moveMainViewController() {
        let vc = UINavigationController(rootViewController: TabBarViewController())
        vc.modalPresentationStyle = .fullScreen
        self.present(vc, animated: true)
    }
    
    private func setPropertiesForPickers() {
        self.authView.picker.delegate = self
        self.authView.picker.dataSource = self
        
        self.authView.sex.textField.delegate = self
        self.authView.target.textField.delegate = self
        self.authView.action.textField.delegate = self
    }

    // MARK: - Constraints
    private func constraits() {
        self.authView.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
            make.width.equalTo(self.mainScroll.snp.width)
            make.height.equalTo(self.mainScroll.snp.height).priority(750)
        }
    }
}

extension AuthViewController: UIPickerViewDataSource, UIPickerViewDelegate, UITextFieldDelegate {
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        self.authView.picker.tag = textField.tag
        self.authView.picker.reloadAllComponents()
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
            self.authView.sex.textField.text = Profile.Sex.allCases[row].rawValue
        case 5:
            self.authView.target.textField.text = Profile.Target.allCases[row].rawValue
        case 6:
            self.authView.action.textField.text = Profile.Action.allCases[row].rawValue
        default:
            break
        }
    }
}
