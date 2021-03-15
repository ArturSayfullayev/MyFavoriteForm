//
//  BasicView.swift
//  MyFavoriteForm
//
//  Created by Artur on 16.02.2021.
//

import UIKit
import SnapKit

class BasicView: UIView {
    // MARK: - Properties
    private let height: Float = 35
    private let width: Float = 150
    
    // MARK: - GUI Variables
    private lazy var label: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 20)
        return label
    }()
    private(set) lazy var textField: UITextField = {
        let textField = UITextField()
        textField.backgroundColor = .white
        textField.layer.cornerRadius = 8
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
        self.addSubviews([self.label,
                          self.textField])
        self.constraints()
    }
    
    // MARK: - Constraints
    private func constraints() {
        self.label.snp.updateConstraints { (make) in
            make.top.left.bottom.equalToSuperview()
            make.right.lessThanOrEqualTo(self.textField.snp.left).offset(-40)
            make.height.equalTo(self.height)
            make.width.equalTo(self.width)
        }
        self.textField.snp.updateConstraints { (make) in
            make.top.right.bottom.equalToSuperview()
            make.height.equalTo(self.height)
            make.width.equalTo(self.width)
        }
    }
    
    // MARK: - Methods
    func setTitle(with text: String) {
        self.label.text = text
    }
    func setKeyboardType(type: UIKeyboardType) {
        self.textField.keyboardType = type
    }
}
