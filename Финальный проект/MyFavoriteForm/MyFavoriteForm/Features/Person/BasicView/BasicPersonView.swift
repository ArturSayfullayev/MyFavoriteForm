//
//  BasicPersonView.swift
//  MyFavoriteForm
//
//  Created by Artur on 21.02.2021.
//

import UIKit
import SnapKit

class BasicPersonView: UIView {
    // MARK: - Properties
    private let width: Float = 150
    private let myOffset: Float = 30
    
    // MARK: - GUI variables
    private lazy var leftLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 20)
        return label
    }()
    private lazy var rightLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 20)
        return label
    }()
    private(set) lazy var textField: UITextField = {
        let textField = UITextField()
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
        self.addSubviews([self.leftLabel,
                          self.rightLabel,
                          self.textField])
        
        self.constraints()
    }
    
    // MARK: - Constraints
    private func constraints() {
        self.leftLabel.snp.makeConstraints { (make) in
            make.top.left.bottom.equalToSuperview()
        }
        self.rightLabel.snp.makeConstraints { (make) in
            make.top.right.bottom.equalToSuperview()
            make.left.greaterThanOrEqualTo(self.leftLabel.snp.right).offset(self.myOffset)
            make.width.equalTo(self.width)
        }
        self.textField.snp.makeConstraints { (make) in
            make.top.right.bottom.equalToSuperview()
            make.left.greaterThanOrEqualTo(self.leftLabel.snp.right).offset(self.myOffset)
            make.width.equalTo(self.width)
        }
    }
    
    // MARK: - Methods
    func setTitle(text: String) {
        self.leftLabel.text = text
    }
    func setValues(text: String) {
        self.rightLabel.text = text
        self.textField.text = text
    }
    func setKeyboardType(type: UIKeyboardType) {
        self.textField.keyboardType = type
    }
    func setEdit(bool: Bool) {
        switch bool {
        case true:
            self.rightLabel.isHidden = false
            self.textField.isHidden = true
        case false:
            self.rightLabel.isHidden = true
            self.textField.isHidden = false
        }
    }
}
