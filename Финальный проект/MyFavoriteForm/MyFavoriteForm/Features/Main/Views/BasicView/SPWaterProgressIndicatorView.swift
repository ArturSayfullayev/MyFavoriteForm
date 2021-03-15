//
//  SPWaterProgressIndicatorView.swift
//  MyFavoriteForm
//
//  Created by Artur on 17.02.2021.
//

import UIKit

class SPWaterProgressIndicatorView: UIView {
    // MARK: - Properties
    private var frequency: CGFloat
    private var amplitude: CGFloat
    private var phaseShift: CGFloat
    private var density: CGFloat
    private var primaryWaveLineWidth: CGFloat
    private var idleAmplitude: CGFloat
    private var phase: CGFloat
    private var displaylink: CADisplayLink?
    private var textLabel: String = ""
    
    private var completionInPercent: Int {
        didSet {
            if completionInPercent > 100 {
                completionInPercent = 100
            } else if completionInPercent < 0 {
                completionInPercent = 0
            }
            self.textLayer.string = String(format: "\(self.textLabel)\n%zd %%", self.completionInPercent)
            self.setNeedsDisplay()
        }
    }
    
    private lazy var textLayer: CATextLayer = {
        let textlayer = CATextLayer.init()
        textlayer.bounds = CGRect(x: 0, y: 0, width: self.bounds.width, height: min(self.bounds.height, 50.0))
        textlayer.position = self.center
        textlayer.alignmentMode = CATextLayerAlignmentMode.center
        textlayer.string = String(format: "%zd %%", self.completionInPercent)
        textlayer.fontSize = CGFloat(self.fontSize)
        textlayer.foregroundColor = UIColor.black.cgColor
        return textlayer
    }()
    
    private let kDefaultFrequency: CGFloat = 1.0
    private let kDefaultAmplitude: CGFloat = 0.8
    private let kDefaultIdleAmplitude: CGFloat = 0.01
    private let kDefaultPhaseShift: CGFloat = -0.1
    private let kDefaultDensity: CGFloat = 5.0
    private let kDefaultPrimaryLineWidth: CGFloat = 3.0
    private let kDefaultFontSize: CGFloat = 20.0
    private let kDefaultMinimumFontSize: CGFloat = 12.0
    private let kDefaultPercent: Int = 0
    private let kDefaultMaximumPercent: Int = 100
    
    private var fontSize: CGFloat {
        didSet {
            self.setNeedsDisplay()
        }
    }
    
    private var waveColor: UIColor {
        didSet {
            self.setNeedsDisplay()
        }
    }
    
    override var frame: CGRect {
        didSet {
            if frame.width != frame.height {
                let side = min(frame.width, frame.height)
                frame = CGRect(x: frame.origin.x,
                               y: frame.origin.y,
                               width: side,
                               height: side)
            }
        }
    }
    
    // MARK: - Initializations
    convenience init() {
        self.init(frame: .zero)
    }
    
    override init(frame: CGRect) {
        
        self.waveColor = UIColor(named: "WaveColor") ?? .cyan
        self.completionInPercent = kDefaultPercent
        self.frequency = kDefaultFrequency
        self.amplitude = kDefaultAmplitude
        self.idleAmplitude = kDefaultIdleAmplitude
        self.phaseShift = kDefaultPhaseShift
        self.density = kDefaultDensity
        self.primaryWaveLineWidth = kDefaultPrimaryLineWidth
        self.fontSize = kDefaultFontSize
        self.phase = 0
        self.displaylink = CADisplayLink()
        
        super.init(frame: frame)
        
        self.setLayer()
    }
    
    required convenience init?(coder aDecoder: NSCoder) {
        self.init(frame: .zero)
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Methods
    @objc private func updateMeters() {
        self.phase += self.phaseShift
        self.setNeedsDisplay()
    }
    
    private func setLayer() {
        let progressPath = UIBezierPath(ovalIn: self.bounds)
        let layer = CAShapeLayer()
        layer.path = progressPath.cgPath
        layer.lineWidth = min(self.bounds.height, self.bounds.width) / 10.0
        
        self.layer.mask = layer
        self.layer.addSublayer(self.textLayer)
        self.backgroundColor = .clear
        
        self.startAnimation()
    }
    
    private func startAnimation() {
        self.displaylink = CADisplayLink(target: self,
                                         selector: #selector(self.updateMeters))
        self.displaylink?.add(to: .main, forMode: .common)
    }
    
    /// Метод обновления прогресса
    func updatePercent(percent: Int) {
        self.completionInPercent = percent
    }
    /// Метод обновления лейбла
    func setLabel(text: String) {
        self.textLabel = text
    }
    
    override func draw(_ rect: CGRect) {
        let context = UIGraphicsGetCurrentContext()
        context?.clear(self.bounds)
        
        self.backgroundColor?.set()
        
        context?.fill(rect)
        context?.setLineWidth(CGFloat(self.primaryWaveLineWidth))
        
        let halfHeight = self.bounds.height / 2.0
        let width: CGFloat = self.bounds.width
        let mid = width / 2.0
        let maxAmplitude = max(halfHeight / 10 - 4.0, CGFloat(2.0 * self.primaryWaveLineWidth))
        
        self.waveColor.withAlphaComponent(self.waveColor.cgColor.alpha).set()
        
        var x = CGFloat(0)
        while  x < (width + self.density) {
            let scaling = -pow(1 / mid * (x - mid), 2) + 1
            
            let y = scaling * maxAmplitude * self.amplitude * sin(CGFloat(2.0 * CGFloat.pi) * (x / width) * self.frequency + self.phase) + self.bounds.height * CGFloat(100 - self.completionInPercent) / CGFloat(100)
            
            if (x == 0) {
                context?.move(to: CGPoint(x: x, y: y))
            } else {
                context?.addLine(to: CGPoint(x: x, y: y))
            }
            
            x += self.density
        }
        context?.addLine(to: CGPoint.init(x: width, y: self.bounds.height))
        context?.addLine(to: CGPoint.init(x: CGFloat(0), y: self.bounds.height))
        context?.closePath()
        context?.fillPath()
        context?.strokePath()
    }
}
