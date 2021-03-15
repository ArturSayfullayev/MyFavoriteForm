//
//  BasicMainLabel.swift
//  MyFavoriteForm
//
//  Created by Artur on 21.02.2021.
//

import UIKit
import SnapKit

class BasicMainLabel: UIView {
    // MARK: - Properties
    private let edgeInsets = UIEdgeInsets(all: 20)
    
    // MARK: - GUI Properties
    private lazy var nameLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 25)
        return label
    }()
    
    private lazy var proteinLabel: BasicLabelAndLabel = {
        let label = BasicLabelAndLabel()
        label.setName(name: "Белков(гр):")
        return label
    }()
    
    private lazy var fatsLabel: BasicLabelAndLabel = {
        let label = BasicLabelAndLabel()
        label.setName(name: "Жиров(гр):")
        
        return label
    }()
    
    private lazy var carbohydratesLabel: BasicLabelAndLabel = {
        let label = BasicLabelAndLabel()
        label.setName(name: "Углеводов(гр):")
        
        return label
    }()
    
    private lazy var caloriesLabel: BasicLabelAndLabel = {
        let label = BasicLabelAndLabel()
        label.setName(name: "Общая калорийность(ккал):")
        
        return label
    }()
    private lazy var stack: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.spacing = 20
        
        return stack
    }()
    
    private lazy var backGroundView = UIView()
    
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
        self.addSubview(self.stack)
        self.stack.addArrangedSubviews([self.nameLabel,
                                        self.proteinLabel,
                                        self.fatsLabel,
                                        self.carbohydratesLabel,
                                        self.caloriesLabel])
        self.constraints()
        self.setProperties()
    }
    
    private func setProperties() {
        self.backgroundColor = UIColor(named: "BackgroundColorOpacity")
        
        self.layer.cornerRadius = 16
        self.layer.borderWidth = 1
        self.layer.borderColor = UIColor.black.cgColor
        self.clipsToBounds = true
    }
    
    private func constraints() {
        self.stack.snp.updateConstraints { (make) in
            make.edges.equalToSuperview().inset(self.edgeInsets)
        }
    }
    
    // MARK: - Setter
    func setValues(name: String, proteins: String, fats: String, carbohydrates: String, calories: String) {
        self.nameLabel.text = name
        self.proteinLabel.setValues(value: proteins)
        self.fatsLabel.setValues(value: fats)
        self.carbohydratesLabel.setValues(value: carbohydrates)
        self.caloriesLabel.setValues(value: calories)
        
        self.setNeedsUpdateConstraints()
    }
}
