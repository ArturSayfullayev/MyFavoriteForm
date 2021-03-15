//
//  WaterTripleBars.swift
//  MyFavoriteForm
//
//  Created by Artur on 17.02.2021.
//

import UIKit
import SnapKit

class WaterTripleBars: UIView {
    // MARK: - GUI Properties
    private lazy var mainWave = SPWaterProgressIndicatorView(frame: .zero)
    private lazy var progressBars = ArcaProgressView()
    
    // MARK: - Inizialization
    override init (frame: CGRect) {
        super.init(frame: frame)
        
        self.initView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func initView() {
        self.backgroundColor = .clear
        self.mainWave = SPWaterProgressIndicatorView(frame: self.bounds)
        self.mainWave.center = self.center
        self.addSubview(self.mainWave)
        
        self.progressBars = ArcaProgressView(frame: CGRect(x: 0,
                                                           y: 0,
                                                           width: self.mainWave.bounds.width + 10,
                                                           height: self.mainWave.bounds.height + 10))
        self.progressBars.center = self.mainWave.center
        self.addSubview(self.progressBars)
        
        self.setPercentAndTextMainBarCalories()
        self.setValueTripleBars()
        self.setTextTripleBars()
    }
    
    private func setPercentAndTextMainBarCalories() {
        self.mainWave.updatePercent(percent: Logic.shared.getPercentCalories())
        self.mainWave.setLabel(text: "\(Logic.shared.getCurrentCalories())/\(Logic.shared.getCalories())")
        
    }
    
    private func setValueTripleBars() {
        self.progressBars.setProgressOne(to: Logic.shared.getPercentProteins(), withAnimation: true)
        self.progressBars.setProgressTwo(to: Logic.shared.getPercentFats(), withAnimation: true)
        self.progressBars.setProgressThree(to: Logic.shared.getPercentCarbohydrates(), withAnimation: true)
    }
    private func setTextTripleBars() {
        self.progressBars.textOne = "белки(гр):\n\(Logic.shared.getCurrentProteins())/\(Logic.shared.getProteins())"
        self.progressBars.textTwo = "жиры(гр):\n\(Logic.shared.getCurrentFats())/\(Logic.shared.getFats())"
        self.progressBars.textThree = "углеводы(гр):\n\(Logic.shared.getCurrentCarbohydrates())/\(Logic.shared.getCarbohydrates())"
    }
}
