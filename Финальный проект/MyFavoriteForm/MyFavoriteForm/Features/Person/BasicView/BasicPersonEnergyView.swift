//
//  BasicPersonEnergyView.swift
//  MyFavoriteForm
//
//  Created by Artur on 21.02.2021.
//

import UIKit
import SnapKit

class BasicPersonEnergyView: UIView {
    // MARK: - GUI variables
    private lazy var topLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 20)
        return label
    }()
    private lazy var bottomLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 20)
        return label
    }()
    private(set) lazy var textField: UITextField = {
        let textField = UITextField()
        textField.textAlignment = .center
        textField.backgroundColor = .white
        textField.layer.cornerRadius = 8
        textField.isHidden = true
        return textField
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
        self.addSubviews([self.topLabel,
                          self.bottomLabel,
                          self.textField])
        
        self.constraints()
    }

    // MARK: - Constraints
    private func constraints() {
        self.topLabel.snp.makeConstraints { (make) in
            make.top.left.right.equalToSuperview()
        }
        self.bottomLabel.snp.makeConstraints { (make) in
            make.top.equalTo(self.topLabel.snp.bottom).offset(20)
            make.left.right.bottom.equalToSuperview()
            make.width.equalTo(50)
        }
        self.textField.snp.makeConstraints { (make) in
            make.top.equalTo(self.topLabel.snp.bottom).offset(20)
            make.left.right.bottom.equalToSuperview()
            make.width.equalTo(50)
        }
    }
    
    // MARK: - Setter
    func setTitle(title: String) {
        self.topLabel.text = title
    }
    func setValue(value: String) {
        self.bottomLabel.text = value
        self.textField.text = value
    }
    func setEdit(bool: Bool) {
        switch bool {
        case true:
            self.bottomLabel.isHidden = false
            self.textField.isHidden = true
        case false:
            self.bottomLabel.isHidden = true
            self.textField.isHidden = false
        }
    }
}


