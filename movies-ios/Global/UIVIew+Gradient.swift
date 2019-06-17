//
//  UIVIew+Gradient.swift
//  movies-ios
//
//  Created by Patrick Ngo on 2019-06-17.
//  Copyright © 2019 patrickngo. All rights reserved.
//

import Foundation
import UIKit

extension UIView {
    
    func addGradientAtBottom() {
        let gradientOverlayLayer = CAGradientLayer.init()
        gradientOverlayLayer.frame = self.frame
        gradientOverlayLayer.startPoint = CGPoint.init(x: 0.5, y: 0.5)
        gradientOverlayLayer.endPoint = CGPoint.init(x: 0.5, y: 1.0)
        gradientOverlayLayer.colors = [UIColor.black.withAlphaComponent(0.0).cgColor, UIColor.black.withAlphaComponent(0.5).cgColor]
        self.layer.insertSublayer(gradientOverlayLayer, at: 0)
    }
}
