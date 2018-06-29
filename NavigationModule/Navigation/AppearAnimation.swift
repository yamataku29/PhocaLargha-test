//
//  AppearAnimation.swift
//  NavigationModule
//
//  Created by Yamada Taku on 2018/06/28.
//  Copyright © 2018 Yamada Taku. All rights reserved.
//

import Foundation
import UIKit

protocol AppearAnimation: class {
    func slideUp(with dialog: FirstBaseView?, backgroundView: UIView?, isBackgroundFadeIn: Bool, duration: TimeInterval)
    func slideUpWithBound()
    func centerZoomIn()
}

protocol DimissAnimation:  class{
    func slideDown(with dialog: FirstBaseView?, backgroundView: UIView?, duration: TimeInterval, delegate: DimissAnimationDelegate?)
}

protocol DimissAnimationDelegate {
    func endDimissAnimation()
}

extension DimissAnimation where Self: UIViewController {
    func slideDown(with dialog: FirstBaseView?, backgroundView: UIView?, duration: TimeInterval, delegate: DimissAnimationDelegate?) {
        UIView.animate(withDuration: duration,
                       delay: 0,
                       usingSpringWithDamping: 1,
                       initialSpringVelocity: 1,
                       options: UIViewAnimationOptions.curveEaseInOut,
                       animations: {
                        backgroundView?.alpha = 0
                        dialog?.frame.origin.y = UIScreen.main.bounds.height
        }, completion: { _ in
            delegate?.endDimissAnimation()
        })
    }
}

extension AppearAnimation where Self: UIViewController {
    func slideUp(with dialog: FirstBaseView?, backgroundView: UIView?, isBackgroundFadeIn: Bool, duration: TimeInterval) {
        guard (dialog != nil) else { return }
        backgroundView?.alpha = 0
        dialog?.frame.origin.y = UIScreen.main.bounds.height
        UIView.animate(withDuration: duration,
                       delay: 0,
                       usingSpringWithDamping: 0.5,
                       initialSpringVelocity: 1,
                       options: UIViewAnimationOptions.allowUserInteraction,
                       animations: {
                        if isBackgroundFadeIn {
                            backgroundView?.alpha = 0.5
                        }
                        dialog?.center.y = UIScreen.main.bounds.midY
                        self.view.layoutIfNeeded()
        }, completion: { _ in
        })
    }
    func slideUpWithBound() {}
    func centerZoomIn() {}
}
