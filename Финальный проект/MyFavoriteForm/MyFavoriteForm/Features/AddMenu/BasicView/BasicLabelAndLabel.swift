//
//  BasicLabelAndLabel.swift
//  MyFavoriteForm
//
//  Created by Artur on 21.02.2021.
//

import UIKit
import SnapKit

class BasicLabelAndLabel: UIView {
    // MARK: - GUI Properties
    private lazy var leftLabel = UILabel()
    private lazy var rightLabel = UILabel()
    
    // MARK: - Inizialization
    override init (frame: CGRect) {
        super.init(frame: frame)
        
        self.initView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Methods
    private func initView() {
        self.addSubviews([self.leftLabel, self.rightLabel])
        self.constraints()
    }
    
    // MARK: - Constraints
    private func constraints() {
        self.leftLabel.snp.makeConstraints { (make) in
            make.top.left.bottom.equalToSuperview()
        }
        self.rightLabel.snp.makeConstraints { (make) in
            make.top.right.bottom.equalToSuperview()
            make.left.greaterThanOrEqualTo(self.leftLabel.snp.right).offset(20)
            make.width.equalTo(50)
        }
    }
    
    // MARK: - Setter
    func setValues(value: String) {
        self.rightLabel.text = value
        
        self.setNeedsUpdateConstraints()
    }
    func setName(name: String) {
        self.leftLabel.text = name
    }
}
