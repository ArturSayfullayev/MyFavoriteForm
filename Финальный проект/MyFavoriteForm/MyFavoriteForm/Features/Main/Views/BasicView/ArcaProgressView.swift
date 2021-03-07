//
//  ArcaProgressView.swift
//  MyFavoriteForm
//
//  Created by Artur on 17.02.2021.
//

import UIKit

class ArcaProgressView: UIView {
    
    // MARK: - Properties
    private let foregroundLayerOne = CAShapeLayer()
    private let backgroundLayerOne = CAShapeLayer()
    
    private let foregroundLayerTwo = CAShapeLayer()
    private let backgroundLayerTwo = CAShapeLayer()
    
    private let foregroundLayerThree = CAShapeLayer()
    private let backgroundLayerThree = CAShapeLayer()
    
    private var progressOne: CGFloat = 0
    private var progressTwo: CGFloat = 0
    private var progressThree: CGFloat = 0
    
    private var duration: Double = 0.5
    private var progressBackgoundColor = UIColor(named: "custom") ?? .white
    private var oneProgressForegroundColor = UIColor.systemBlue
    private var twoProgressForegroundColor = UIColor.systemIndigo
    private var threeProgressForegroundColor = UIColor.systemPurple
    
    private var lineWidth: CGFloat = 5 {
        didSet{
            self.foregroundLayerOne.lineWidth = self.lineWidth
            self.backgroundLayerOne.lineWidth = self.lineWidth
            self.foregroundLayerTwo.lineWidth = self.lineWidth
            self.backgroundLayerTwo.lineWidth = self.lineWidth
            self.foregroundLayerThree.lineWidth = self.lineWidth
            self.backgroundLayerThree.lineWidth = self.lineWidth
        }
    }
    
    private var radius: CGFloat {
        (min(self.frame.width, self.frame.height) - self.lineWidth) / 2
    }
    
    private var pathCenter: CGPoint {
        self.convert(self.center, from: self.superview)
    }
    
    var textOne: String = ""
    var textTwo: String = ""
    var textThree: String = ""
    
    // MARK: - Methods
    func setProgressOne(to progressConstant: Double, withAnimation: Bool) {
        var progress: Double {
            get {
                if progressConstant > 1 { return 1 }
                else if progressConstant < 0 { return 0 }
                else { return progressConstant }
            }
        }
        self.progressOne = CGFloat(progress)
        self.foregroundLayerOne.strokeEnd = CGFloat(progress)
        
        if withAnimation {
            let animation = CABasicAnimation(keyPath: "strokeEnd")
            animation.fromValue = 0
            animation.toValue = progress
            animation.duration = self.duration
            self.foregroundLayerOne.add(animation, forKey: "foregroundAnimation")
        }
    }
    
    func setProgressTwo(to progressConstant: Double, withAnimation: Bool) {
        var progress: Double {
            get {
                if progressConstant > 1 { return 1 }
                else if progressConstant < 0 { return 0 }
                else { return progressConstant }
            }
        }
        self.progressTwo = CGFloat(progress)
        self.foregroundLayerTwo.strokeEnd = CGFloat(progress)
        
        if withAnimation {
            let animation = CABasicAnimation(keyPath: "strokeEnd")
            animation.fromValue = 0
            animation.toValue = progress
            animation.duration = self.duration
            self.foregroundLayerTwo.add(animation, forKey: "foregroundAnimation")
        }
    }
    
    func setProgressThree(to progressConstant: Double, withAnimation: Bool) {
        var progress: Double {
            get {
                if progressConstant > 1 { return 1 }
                else if progressConstant < 0 { return 0 }
                else { return progressConstant }
            }
        }
        self.progressThree = CGFloat(progress)
        self.foregroundLayerThree.strokeEnd = CGFloat(progress)
        
        if withAnimation {
            let animation = CABasicAnimation(keyPath: "strokeEnd")
            animation.fromValue = 0
            animation.toValue = progress
            animation.duration = self.duration
            self.foregroundLayerThree.add(animation, forKey: "foregroundAnimation")
        }
    }
    
    //MARK: Private
    private func makeBar() {
        self.layer.sublayers = nil
        self.drawBackgroundLayerFirstBar()
        self.drawForegroundLayerFirstBar()
        self.drawBackgroundLayerSecondBar()
        self.drawForegroundLayerSecondBar()
        self.drawBackgroundLayerThirdBar()
        self.drawForegroundLayerThirdBar()
    }
    
    // MARK: - First bar
    private let oneStartAngle = CGFloat.pi * 2.6 / 3
    private let oneEndAngle = CGFloat.pi * 4.4 / 3
    
    private func drawBackgroundLayerFirstBar() {
        let path = UIBezierPath(arcCenter: self.pathCenter,
                                radius: self.radius,
                                startAngle: self.oneStartAngle ,
                                endAngle: self.oneEndAngle,
                                clockwise: true)
        
        self.backgroundLayerOne.lineCap = CAShapeLayerLineCap.round
        self.backgroundLayerOne.path = path.cgPath
        self.backgroundLayerOne.lineWidth = self.lineWidth
        self.backgroundLayerOne.fillColor = UIColor.clear.cgColor
        self.backgroundLayerOne.strokeColor = self.progressBackgoundColor.cgColor
        
        self.layer.addSublayer(self.backgroundLayerOne)
    }
    
    private func drawForegroundLayerFirstBar() {
        let path = UIBezierPath(arcCenter: self.pathCenter,
                                radius: self.radius,
                                startAngle: self.oneStartAngle,
                                endAngle: self.oneEndAngle,
                                clockwise: true)
        
        self.foregroundLayerOne.lineCap = CAShapeLayerLineCap.round
        self.foregroundLayerOne.path = path.cgPath
        self.foregroundLayerOne.lineWidth = self.lineWidth
        self.foregroundLayerOne.fillColor = UIColor.clear.cgColor
        self.foregroundLayerOne.strokeColor = self.oneProgressForegroundColor.cgColor
        self.foregroundLayerOne.strokeEnd = self.progressOne
        
        self.layer.addSublayer(self.foregroundLayerOne)
        
    }
    
    private func makeOneTitleLabel(withText text: String) -> UILabel {
        let label = UILabel(frame: CGRect(x: self.lineWidth - 100,
                                          y: self.frame.height - self.lineWidth - 90, width: 100, height: 40))
        label.text = text
        label.numberOfLines = 0
        label.textAlignment = .center
        label.font = UIFont.boldSystemFont(ofSize: 15.0)
        label.textColor = .black
        return label
    }
    
    // MARK: - Second bar
    private let twoStartAngle = CGFloat.pi * 0.4 / 3
    private let twoEndAngle = CGFloat.pi * 4.6 / 3
    
    private func drawBackgroundLayerSecondBar() {
        let path = UIBezierPath(arcCenter: self.pathCenter,
                                radius: self.radius,
                                startAngle: self.twoStartAngle,
                                endAngle: self.twoEndAngle,
                                clockwise: false)
        
        self.backgroundLayerTwo.path = path.cgPath
        self.backgroundLayerTwo.strokeColor = self.progressBackgoundColor.cgColor
        self.backgroundLayerTwo.lineWidth = self.lineWidth
        self.backgroundLayerTwo.lineCap = CAShapeLayerLineCap.round
        self.backgroundLayerTwo.fillColor = UIColor.clear.cgColor
        self.layer.addSublayer(self.backgroundLayerTwo)
    }
    
    private func drawForegroundLayerSecondBar() {
        let path = UIBezierPath(arcCenter: self.pathCenter,
                                radius: self.radius,
                                startAngle: self.twoStartAngle,
                                endAngle: self.twoEndAngle,
                                clockwise: false)
        
        self.foregroundLayerTwo.lineCap = CAShapeLayerLineCap.round
        self.foregroundLayerTwo.path = path.cgPath
        self.foregroundLayerTwo.lineWidth = self.lineWidth
        self.foregroundLayerTwo.fillColor = UIColor.clear.cgColor
        self.foregroundLayerTwo.strokeColor = self.twoProgressForegroundColor.cgColor
        self.foregroundLayerTwo.strokeEnd = self.progressTwo
        
        self.layer.addSublayer(self.foregroundLayerTwo)
        
    }
    
    private func makeTwoTitleLabel(withText text: String) -> UILabel {
        let label = UILabel(frame: CGRect(x: self.frame.width - 5,
                                          y: self.frame.height - self.lineWidth - 90, width: 100, height: 40))
        label.text = text
        label.numberOfLines = 0
        label.textAlignment = .center
        label.font = UIFont.boldSystemFont(ofSize: 15.0)
        label.textColor = .black
        return label
    }
    
    // MARK: - Third bar
    private let threeStartAngle = CGFloat.pi * 2.4 / 3
    private let threeEndAngle = CGFloat.pi * 0.6 / 3
    
    private func drawBackgroundLayerThirdBar() {
        let path = UIBezierPath(arcCenter: self.pathCenter,
                                radius: self.radius,
                                startAngle: self.threeStartAngle,
                                endAngle: self.threeEndAngle,
                                clockwise: false)
        
        self.backgroundLayerThree.path = path.cgPath
        self.backgroundLayerThree.strokeColor = self.progressBackgoundColor.cgColor
        self.backgroundLayerThree.lineWidth = self.lineWidth
        self.backgroundLayerThree.lineCap = CAShapeLayerLineCap.round
        self.backgroundLayerThree.fillColor = UIColor.clear.cgColor
        self.layer.addSublayer(self.backgroundLayerThree)
        
    }
    
    private func drawForegroundLayerThirdBar() {
        let path = UIBezierPath(arcCenter: self.pathCenter,
                                radius: self.radius,
                                startAngle: self.threeStartAngle,
                                endAngle: self.threeEndAngle,
                                clockwise: false)
        
        self.foregroundLayerThree.lineCap = CAShapeLayerLineCap.round
        self.foregroundLayerThree.path = path.cgPath
        self.foregroundLayerThree.lineWidth = self.lineWidth
        self.foregroundLayerThree.fillColor = UIColor.clear.cgColor
        self.foregroundLayerThree.strokeColor = self.threeProgressForegroundColor.cgColor
        self.foregroundLayerThree.strokeEnd = self.progressThree
        
        self.layer.addSublayer(self.foregroundLayerThree)
        
    }
    
    private func makeThreeTitleLabel(withText text: String) -> UILabel {
        let label = UILabel(frame: CGRect(x: self.frame.width / 2 - 60,
                                          y: self.frame.height - self.lineWidth + 10, width: 105, height: 55))
        label.text = text
        label.numberOfLines = 0
        label.textAlignment = .center
        label.font = UIFont.boldSystemFont(ofSize: 15.0)
        label.textColor = .black
        return label
    }
    
    private func setupView() {
        self.makeBar()
        self.addSubview(self.makeOneTitleLabel(withText: self.textOne))
        self.addSubview(self.makeTwoTitleLabel(withText: self.textTwo))
        self.addSubview(self.makeThreeTitleLabel(withText: self.textThree))
    }
    
    // MARK: - Layout Sublayers
    private var layoutDone = false
    override func layoutSublayers(of layer: CALayer) {
        if !self.layoutDone {
            self.setupView()
            self.layoutDone = true
        }
    }
}
