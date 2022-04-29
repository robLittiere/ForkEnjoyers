//
//  UIViewExtension.swift
//  ForkEnjoyers
//
//  Created by Robin on 28/04/2022.
//

import Foundation
import UIKit
extension UIView {
    
    public func addInnerShadow(topColor: UIColor = UIColor.black, height: Double) {
        let shadowLayer = CAGradientLayer()
        shadowLayer.cornerRadius = layer.cornerRadius
        shadowLayer.frame = bounds
        shadowLayer.frame.size.height = height
        shadowLayer.shadowRadius = 4
        shadowLayer.opacity = 0.3
        shadowLayer.shadowOffset = CGSize(width: 0.0, height: -2)
        shadowLayer.colors = [
            topColor.cgColor,
            topColor.cgColor
        ]
        layer.addSublayer(shadowLayer)
    }
    
}

