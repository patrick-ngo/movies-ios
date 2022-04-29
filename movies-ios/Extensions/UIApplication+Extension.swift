//
//  UIApplication+Extension.swift
//  movies-ios
//
//  Created by Patrick Ngo on 2022-04-30.
//  Copyright © 2022 patrickngo. All rights reserved.
//

import UIKit

extension UIApplication {
  var currentWindow: UIWindow? {
    return UIApplication.shared.windows.first { $0.isKeyWindow }
  }

  var statusBarHeight: CGFloat {
    if #available(iOS 13.0, *) {
        return currentWindow?.windowScene?.statusBarManager?.statusBarFrame.height ?? 0
    } else {
        return UIApplication.shared.statusBarFrame.height
    }
  }
}
