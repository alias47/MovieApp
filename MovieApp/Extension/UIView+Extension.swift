//
//  UIView+Extension.swift
//  MovieApp
//
//  Created by atit on 19/09/2022.
//

import UIKit

enum GradientStyle {
    case vertical
    case horizontal
    case diagonalLeftRightTopBottom
    case diagonalRightLeftTopBottom
    case custom
}

extension UIView {
    func addSubViews(_ views: UIView...) {
        views.forEach({ addSubview($0) })
    }
    
    //cell identifier
    static var identifier: String {
        return String(describing: self)
    }
    
    func applyBackgroundGradient(fromColor: CGColor, toColor: CGColor, style: GradientStyle, bounds: CGRect, startPoint: CGPoint = .zero, endPoint: CGPoint = .zero) {
        let gradientLayer = CAGradientLayer()
        gradientLayer.colors = [fromColor, toColor]
        gradientLayer.frame = bounds
        
        var stPoint = startPoint
        var enPoint = endPoint
        
        switch style {
        case .horizontal:
            stPoint = CGPoint(x: 0, y: 0)
            enPoint = CGPoint(x: 1, y: 0)
            
        case .vertical:
            stPoint = CGPoint(x: 0, y: 0)
            enPoint = CGPoint(x: 0, y: 1)
            
        case .diagonalLeftRightTopBottom:
            stPoint = CGPoint(x: 0, y: 0)
            enPoint = CGPoint(x: 1, y: 1)
            
        case .diagonalRightLeftTopBottom:
            stPoint = CGPoint(x: 1, y: 0)
            enPoint = CGPoint(x: 0, y: 1)
        default: break
        }
        
        gradientLayer.startPoint = stPoint
        gradientLayer.endPoint = enPoint
        
        if let sublayers = self.layer.sublayers {
            _ = sublayers.map {
                if $0 is CAGradientLayer {
                    $0.removeFromSuperlayer()
                }
            }
        }
        self.layer.insertSublayer(gradientLayer, at: 0)
    }
}
