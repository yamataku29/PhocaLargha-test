//
//  ConfigureOption.swift
//  NavigationModule
//
//  Created by Yamada Taku on 2018/06/29.
//  Copyright © 2018 Yamada Taku. All rights reserved.
//

import Foundation
import UIKit

struct ConfigureOption {
    var backgroundColor: UIColor
    var backgroundAlpha: CGFloat
    var pageControlColor: UIColor
    var isDimissAnimation: Bool
    var isBackgroundFadeIn: Bool
    var isDismissibleForTap: Bool
    var shouldDisplayPageControl: Bool

    init(backgroundColor: UIColor = UIColor.black,
         backgroundAlpha: CGFloat = 0.5,
         pageControlColor: UIColor = .orange,
         isDimissAnimation: Bool = false,
         isBackgroundFadeIn: Bool = true,
         isDismissibleForTap: Bool = true,
         shouldDisplayPageControl: Bool = true) {
        self.backgroundColor = backgroundColor
        self.backgroundAlpha = backgroundAlpha
        self.pageControlColor = pageControlColor
        self.isDimissAnimation = isDimissAnimation
        self.isBackgroundFadeIn = isBackgroundFadeIn
        self.isDismissibleForTap = isDismissibleForTap
        self.shouldDisplayPageControl = shouldDisplayPageControl
    }
}
