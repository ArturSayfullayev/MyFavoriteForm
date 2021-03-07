//
//  BasicViewOneStack.swift
//  MyFavoriteForm
//
//  Created by Artur on 23.02.2021.
//

import UIKit
import SnapKit

class BasicViewOneStack: UIView {
    // MARK: - GUI Properties
    private lazy var label = UILabel()
    
    private lazy var textField: UITextField = {
        let textField = UITextField()
        textField.backgroundColor = .white
        textField.layer.cornerRadius = 6
        
        return textField
    }()
    private lazy var stack: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.spacing = 20
        stack.distribution = .fillEqually
        
        return stack
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
        self.addSubview(self.stack)
        self.stack.addArrangedSubviews([self.label,
                                        self.textField])
   
        self.constraints()
    }
    
    // MARK: - Constraints
    private func constraints() {
        self.stack.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
        self.textField.snp.makeConstraints { (make) in
            make.height.equalTo(30)
        }
    }
    // MARK: - Setter
    func setLabelText(text: String) {
        self.label.text = text
    }
    func setNumPad(keyboardType: UIKeyboardType) {
        self.textField.keyboardType = keyboardType
    }
    
    // MARK: - Getter
    func getTextFromTextField() -> String? {
        self.textField.text
    }
}
