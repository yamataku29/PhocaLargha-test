//
//  ComponentConfigure.swift
//  NavigationModule
//
//  Created by Yamada Taku on 2018/08/01.
//  Copyright © 2018 Yamada Taku. All rights reserved.
//

import Foundation
import UIKit

struct BaseViewComponent {
    enum ViewType {
        case large
        case medium
        case small
    }

    var viewType: ViewType
    var cornerRadius: CGFloat
    var topComponent: TopComponent?
    var footerComponent: FooterComponent?
    var image: UIImage
    var baseViewColor: UIColor

    init(viewType: ViewType,
         cornerRadius: CGFloat = 10,
         topComponent: TopComponent? = nil,
         footerComponent: FooterComponent? = nil,
         image: UIImage,
         baseViewColor: UIColor = .white) {
        self.viewType = viewType
        self.cornerRadius = cornerRadius
        self.topComponent = topComponent
        self.footerComponent = footerComponent
        self.image = image
        self.baseViewColor = baseViewColor
    }
}

struct TopComponent {
    var text: String
    var textColor: UIColor
    var font: UIFont
    var height: CGFloat

    init(text: String,
         textColor: UIColor = .black,
         font: UIFont = .boldSystemFont(ofSize: 22),
         height: CGFloat = 80) {
        self.text = text
        self.textColor = textColor
        self.font = font
        self.height = height
    }
}

struct FooterComponent {
    var buttonTitle: String?
    var buttonColor: UIColor?
    var buttonTextColor: UIColor?
    var backgroundColor: UIColor
    var buttonTextFont: UIFont?
    var height: CGFloat
    var completion: (() -> ())?

    init(buttonTitle: String? = nil,
         buttonColor: UIColor? = .white,
         buttonTextColor: UIColor? = .black,
         backgroundColor: UIColor = .clear,
         buttonTextFont: UIFont? = UIFont.boldSystemFont(ofSize: 16),
         height: CGFloat = 50,
         completion: (() -> ())? = nil) {
        self.buttonTitle = buttonTitle
        self.buttonColor = buttonColor
        self.buttonTextColor = buttonTextColor
        self.backgroundColor = backgroundColor
        self.buttonTextFont = buttonTextFont
        self.height = height
        self.completion = completion
    }
}
