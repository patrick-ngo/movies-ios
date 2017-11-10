//
//  UIColor+Hex.swift
//  movies-ios
//
//  Created by Patrick Ngo on 11/10/17.
//  Copyright © 2017 patrickngo. All rights reserved.
//

import UIKit

extension UIColor {
    
    
    convenience init(hex: Int) {
        self.init(red: (CGFloat((hex & 0xff0000) >> 16)) / 255.0, green: (CGFloat((hex & 0xff00) >> 8)) / 255.0, blue: (CGFloat(hex & 0xff)) / 255.0, alpha: 1.0)
    }
    
    
    struct Button {
        static let pink = UIColor(hex: 0xff00bf)
        static let blue = UIColor(hex: 0x352385)
        static let darkBlue = UIColor(hex: 0x333447)
    }
    
    struct Text {
        static let darkBlue = UIColor(hex: 0x333447)
        static let darkGrey = UIColor(hex: 0x333333)
    }
    
    struct Border {
        static let around = UIColor(hex: 0xF1F1F1)
        static let inside = UIColor(hex: 0xF4F4F4)
    }
    
    struct Background {
        static let grey = UIColor(hex: 0xf3f3f5)
    }
    
    struct NavBar {
        static let pink = UIColor(hex: 0xff00bf)
    }
}
