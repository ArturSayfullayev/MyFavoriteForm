//
//  PlainHorizontalProgressBar.swift
//  MyFavoriteForm
//
//  Created by Artur on 17.02.2021.
//

import UIKit

class PlainHorizontalProgressBar: UIView {
    
    // MARK: - Properties
    private let progressLayer = CALayer()
    private let backgroundMask = CAShapeLayer()
    
    private var color: UIColor = UIColor(named: "ProgressBar") ?? .blue
    
    private var progress: CGFloat = 0 {
        didSet { setNeedsDisplay() }
    }

    // MARK: - Inicialization
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.setupLayers()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }

    // MARK: - Methods
    private func setupLayers() {
        layer.addSublayer(self.progressLayer)
        
    }
    func setProgress(value: Double) {
        self.progress = CGFloat(value)
    }
    
    override func draw(_ rect: CGRect) {
        self.backgroundMask.path = UIBezierPath(roundedRect: rect, cornerRadius: 9).cgPath
        layer.mask = self.backgroundMask
        
        let progressRect = CGRect(origin: .zero, size: CGSize(width: rect.width * self.progress,
                                                              height: rect.height))
        self.progressLayer.frame = progressRect
        self.progressLayer.backgroundColor = self.color.cgColor
    }
}
