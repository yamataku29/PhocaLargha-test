//
//  PopNavi.swift
//  NavigationModule
//
//  Created by Yamada Taku on 2018/06/28.
//  Copyright © 2018 Yamada Taku. All rights reserved.
//

import UIKit

open class PopNavi: UIViewController {
    enum BaseViewSize {
        case small
        case medium
        case large
    }
    var baseViewdColor = UIColor.white
    var baseViewSizeType: BaseViewSize  = .large
    var backgroundColor = UIColor.black
    var backgroundAlpha: CGFloat = 0.5

    override open func viewDidLoad() {
        super.viewDidLoad()
        configureBackgroundView()
        configureBaseView()
    }
}

private extension PopNavi {
    var screenFrame: CGRect {
        return UIScreen.main.bounds
    }
    var baseViewSize: CGSize {
        switch baseViewSizeType {
        case .small:
            return CGSize(width: screenFrame.width/1.5, height: screenFrame.height/2.5)
        case .medium:
            return CGSize(width: screenFrame.width/1.3, height: screenFrame.height/2)
        case .large:
            return CGSize(width: screenFrame.width/1.1, height: screenFrame.height/1.5)
        }
    }
    func configureBackgroundView() {
        let backgroundView = UIView(frame: UIScreen.main.bounds)
        backgroundView.backgroundColor = backgroundColor
        backgroundView.alpha = backgroundAlpha
        view.addSubview(backgroundView)
    }

    func configureBaseView() {
        let baseView = UIView()
        baseView.frame.size = baseViewSize
        baseView.backgroundColor = baseViewdColor
        baseView.center = view.center
        view.addSubview(baseView)
    }
}
