//
//  CustomButton.swift
//  MyFavoriteForm
//
//  Created by Artur on 16.02.2021.
//

import UIKit
import SnapKit

class CustomButton: UIButton {
    // MARK: - GUI Properties
    private lazy var mainImage: UIImageView = {
        let image = UIImageView()
        image.contentMode = .scaleAspectFill
        image.clipsToBounds = true
        image.layer.cornerRadius = 18
        
        return image
    }()
    
    private lazy var label: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "Palatino", size: 18)
        
        return label
    }()

    // MARK: - Init
    override init (frame: CGRect) {
        super.init(frame: frame)
        
        self.initView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Methods
    private func initView() {
        self.backgroundColor = UIColor(named: "custom")
        self.addSubviews([self.mainImage,
                          self.label])
        
        self.constraints()
        self.setLayers()
    }
    
    private func setLayers() {
        self.layer.cornerRadius = 18
        self.layer.shadowOpacity = 0.4
        self.layer.borderWidth = 1
        self.layer.borderColor = UIColor.black.cgColor
    }
    
    // MARK: - Constraints
    private func constraints() {
        self.mainImage.snp.makeConstraints { (make) in
            make.top.left.bottom.equalToSuperview().inset(10)
            make.width.height.equalTo(50)
        }
        self.label.snp.makeConstraints { (make) in
            make.top.right.bottom.equalToSuperview().inset(10)
            make.left.equalTo(self.mainImage.snp.right).offset(40)
        }
    }
    
    // MARK: - Setter
    func setLabel(title: String) {
        self.label.text = title
    }
    func setImage(image: String) {
        mainImage.image = UIImage(named: image)
    }
}
