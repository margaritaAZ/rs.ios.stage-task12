//
//  GlassView.swift
//  RSSchool_T12
//
//  Created by Маргарита Жучик on 23.09.21.
//

import UIKit

class GlassView: UIView {
    private let cornerRadius: CGFloat = 20
    private lazy var path = UIBezierPath(roundedRect: bounds, cornerRadius: cornerRadius)
    private lazy var gradientLayer: CAGradientLayer = {
        let layer = CAGradientLayer()
        layer.cornerRadius = cornerRadius
        layer.cornerCurve = .continuous
        layer.colors = [
            UIColor(red: 1, green: 1, blue: 0.984, alpha: 0.15).cgColor,
            UIColor(red: 1, green: 1, blue: 0.984, alpha: 0.55).cgColor
        ]
        layer.locations = [0,0.75, 1]
        layer.startPoint = CGPoint(x: 0, y: 0)
        layer.endPoint = CGPoint(x: 1, y: 1)
        return layer
    }()
    private lazy var borderLayer: CAGradientLayer = {
        let layer = CAGradientLayer()
        layer.cornerRadius = cornerRadius
        layer.cornerCurve = .continuous
        layer.colors = [
            UIColor(red: 1, green: 1, blue: 0.984, alpha: 0.15).cgColor,
            UIColor(red: 1, green: 1, blue: 0.984, alpha: 0.40).cgColor
        ]
        layer.locations = [0,0.75, 1]
        layer.startPoint = CGPoint(x: 0, y: 0)
        layer.endPoint = CGPoint(x: 1, y: 1)
        layer.mask = shapeLayer
        return layer
    }()
    private lazy var shapeLayer: CAShapeLayer = {
        let mask = CAShapeLayer()
        mask.fillColor = UIColor.clear.cgColor
        mask.strokeColor = UIColor.white.cgColor
        mask.lineWidth = 1
        mask.cornerCurve = .continuous
        return mask
    }()
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupView()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        borderLayer.frame = bounds
        gradientLayer.frame = bounds
        shapeLayer.path = path.cgPath
        layer.shadowPath = path.cgPath
    }
    
    func setupView() {
        layer.cornerRadius = cornerRadius
        layer.cornerCurve = .continuous
        backgroundColor = .white.withAlphaComponent(0)
        layer.shadowColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.02).cgColor
        layer.shadowOpacity = 1
        layer.shadowRadius = 50
        layer.shadowOffset = CGSize(width: 20, height: 20)
        
        layer.insertSublayer(gradientLayer, at: 0)
        layer.addSublayer(borderLayer)
    }
    
}
