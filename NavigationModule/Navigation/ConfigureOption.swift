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
    var isDimissAnimation: Bool
    var isBackgroundFadeIn: Bool
    var isDismissibleForTap: Bool

    init(backgroundColor: UIColor = UIColor.black,
         backgroundAlpha: CGFloat = 0.5,
         isDimissAnimation: Bool = false,
         isBackgroundFadeIn: Bool = true,
         isDismissibleForTap: Bool = false) {
        self.backgroundColor = backgroundColor
        self.backgroundAlpha = backgroundAlpha
        self.isDimissAnimation = isDimissAnimation
        self.isBackgroundFadeIn = isBackgroundFadeIn
        self.isDismissibleForTap = isDismissibleForTap
    }
}
