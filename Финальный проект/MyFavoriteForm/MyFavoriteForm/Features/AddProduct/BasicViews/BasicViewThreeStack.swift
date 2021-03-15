//
//  BasicViewThreeStack.swift
//  MyFavoriteForm
//
//  Created by Artur on 23.02.2021.
//

import UIKit
import SnapKit

class BasicViewThreeStack: UIView {
    // MARK: - GUI Properties
    private lazy var stack: UIStackView = {
        let stack = UIStackView()
        stack.axis = .horizontal
        stack.spacing = 30
        stack.distribution = .fillEqually
        return stack
    }()
    
    private lazy var proteinView: BasicViewOneStack = {
        let protein = BasicViewOneStack()
        protein.setLabelText(text: "Белки:")
        protein.setNumPad(keyboardType: .numbersAndPunctuation)
        
        return protein
    }()
    private lazy var fatsView: BasicViewOneStack = {
        let fats = BasicViewOneStack()
        fats.setLabelText(text: "Жиры:")
        fats.setNumPad(keyboardType: .numbersAndPunctuation)
        
        return fats
    }()
    private lazy var carbohydrateView: BasicViewOneStack = {
        let carbohydrate = BasicViewOneStack()
        carbohydrate.setLabelText(text: "Углеводы:")
        carbohydrate.setNumPad(keyboardType: .numbersAndPunctuation)
        
        return carbohydrate
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
        self.stack.addArrangedSubviews([self.proteinView,
                                        self.fatsView,
                                        self.carbohydrateView])
        self.constraints()
    }
    
    // MARK: - Constraints
    private func constraints() {
        self.stack.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
    }
    
    // MARK: - Getter
    func getValuesFromTextField() -> (protein: String?, fats: String?, carbohydrates: String?) {
        return (protein: self.proteinView.getTextFromTextField(),
                fats: self.fatsView.getTextFromTextField(),
                carbohydrates: self.carbohydrateView.getTextFromTextField())
    }
}
