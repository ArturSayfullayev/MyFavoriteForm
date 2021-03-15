//
//  WaterProgress+Label.swift
//  MyFavoriteForm
//
//  Created by Artur on 19.02.2021.
//

import UIKit
import SnapKit

class WaterProgressLabel: UIView {
    // MARK: - Properties
    private let edgeInsets = UIEdgeInsets(all: 10)
    
    // MARK: - GUI Properties
    private(set) lazy var waterProgress: PlainHorizontalProgressBar = {
        let progress = PlainHorizontalProgressBar()
        progress.backgroundColor = UIColor(named: "custom") ?? .lightGray
        
        return progress
    }()
    private lazy var label: UILabel = {
        let label = UILabel()
        label.numberOfLines = 2
        label.lineBreakMode = .byWordWrapping
        label.textAlignment = .center
        
        return label
    }()
    
    // MARK: - Inizialization
    override init (frame: CGRect) {
        super.init(frame: frame)
        
        self.initView()
        self.constraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func initView() {
        self.addSubviews([self.waterProgress,
                          self.label])
    }
    // MARK: - Canstraints
    private func constraints() {
        self.waterProgress.snp.makeConstraints { (make) in
            make.left.equalToSuperview().inset(self.edgeInsets)
            make.centerY.equalTo(self.label.snp.centerY)
            make.height.equalTo(25)
        }
        self.label.snp.makeConstraints { (make) in
            make.top.bottom.equalToSuperview()
            make.right.equalToSuperview().inset(self.edgeInsets)
            make.left.equalTo(self.waterProgress.snp.right).offset(15)
            make.width.equalTo(100)
            make.height.equalTo(50)
        }
    }
    
    // MARK: - Setter
    func setTextWaterBar(text: String) {
        self.label.text = text
    }
}
