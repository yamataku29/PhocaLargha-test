//
//  BaseView.swift
//  NavigationModule
//
//  Created by Yamada Taku on 2018/06/29.
//  Copyright © 2018 Yamada Taku. All rights reserved.
//

import Foundation
import UIKit

struct TopComponent {
    var text: String
    var textColor: UIColor
    var font: UIFont
    var labelHeight: CGFloat

    init(text: String,
         textColor: UIColor = .white,
         font: UIFont = .systemFont(ofSize: 16),
         labelHeight: CGFloat = 50) {
        self.text = text
        self.textColor = textColor
        self.font = font
        self.labelHeight = labelHeight
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
         buttonTextFont: UIFont? = UIFont.boldSystemFont(ofSize: 12),
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

class BaseView: UIView {
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    convenience init(component: BaseViewComponent, with superViewSize: CGSize,
                     centerPosition: CGPoint, gesture: UITapGestureRecognizer? = nil,
                     textFieldDelegate: UITextFieldDelegate) {
        var baseViewFrame = CGRect()
        switch component.viewType {
        case .small:
            baseViewFrame = CGRect(x: 0, y: 0, width: superViewSize.width/1.5,
                                   height: superViewSize.height/2.3)
        case .medium:
            baseViewFrame = CGRect(x: 0, y: 0, width: superViewSize.width/1.5,
                                   height: superViewSize.height/2)
        case .large:
            baseViewFrame = CGRect(x: 0, y: 0, width: superViewSize.width/1.3,
                                   height: superViewSize.height/1.8)
        }
        self.init(frame: baseViewFrame)
        center = centerPosition
        backgroundColor = component.baseViewColor
        delegate = textFieldDelegate

        let topViewHeight = component.topComponent?.labelHeight ?? 0
        let bottomViewHeight = component.footerComponent?.height ?? 0
        setImage(with: component.image, topViewHeight: topViewHeight, bottomViewHeight: bottomViewHeight)

        if let topComponent = component.topComponent {
            setTopView(text: topComponent.text, textColor: topComponent.textColor,
                       font: topComponent.font, labelHeight: topComponent.labelHeight)
        }

        if let footerComponent = component.footerComponent {
            setFooterView(component: footerComponent, cornerRadius: component.cornerRadius,
                          width: bounds.width, gesture: gesture)
        }
    }
    weak var delegate: UITextFieldDelegate?
    func setMessageTextView() {

    }
    func setTopView(text: String, textColor: UIColor, font: UIFont, labelHeight: CGFloat) {
        let titleLabel = UILabel()
        titleLabel.bounds.size = CGSize(width: bounds.width, height: labelHeight)
        titleLabel.center = CGPoint(x: bounds.width/2, y: labelHeight/2)
        titleLabel.text = text
        titleLabel.textColor = textColor
        titleLabel.textAlignment = .center
        titleLabel.font = font
        titleLabel.lineBreakMode = .byWordWrapping
        titleLabel.numberOfLines = 10
        addSubview(titleLabel)
    }
    func setFooterView(component: FooterComponent, cornerRadius: CGFloat,
                       width: CGFloat, gesture: UITapGestureRecognizer?) {
        let footerViewFrame = CGRect(x: 0, y: bounds.height - component.height,
                                     width: bounds.width, height: component.height)
        let footerView = FooterView(component: component, frame: footerViewFrame,
                                    cornerRadius: cornerRadius, gesture: gesture)
        footerView.backgroundColor = component.backgroundColor
        footerView.setBottomRoundCorner(with: CGSize(width: cornerRadius, height: cornerRadius))
        addSubview(footerView)
    }
    func setImage(with image: UIImage, topViewHeight: CGFloat, bottomViewHeight: CGFloat) {
        let imageView = UIImageView(image: image)
        let centerOffset = bottomViewHeight-topViewHeight
        imageView.bounds.size = CGSize(width: bounds.width,
                                       height: bounds.height - bottomViewHeight - bottomViewHeight)
        imageView.center.x = bounds.width/2
        imageView.center.y = bounds.height/2+centerOffset
        imageView.contentMode = .scaleAspectFit
        addSubview(imageView)
    }
}

class FirstBaseView: BaseView {}
class LastBaseView: BaseView {}
class TitleView: UIView {}

class FooterView: UIView {
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    convenience init(component: FooterComponent,
                     frame: CGRect, cornerRadius: CGFloat, gesture: UITapGestureRecognizer?) {
        self.init(frame: frame)
        setFooterButton(component: component, cornerRadius: cornerRadius, gesture: gesture)
    }
    func setFooterButton(component: FooterComponent, cornerRadius: CGFloat,
                         gesture: UITapGestureRecognizer? = nil) {
        let buttonView = FooterButtonView()
        if let gesture = gesture {
            buttonView.addGestureRecognizer(gesture)
        }
        buttonView.bounds.size = CGSize(width: bounds.width*2/3, height: bounds.height*3/5)
        buttonView.center = CGPoint(x: bounds.width/2, y: bounds.height/2)
        buttonView.layer.cornerRadius = cornerRadius
        buttonView.backgroundColor = component.buttonColor

        let titleLabel = UILabel()
        titleLabel.text = component.buttonTitle
        titleLabel.textColor = component.buttonTextColor
        titleLabel.sizeToFit()
        titleLabel.font = component.buttonTextFont
        titleLabel.textAlignment = .center
        titleLabel.center = CGPoint(x: buttonView.bounds.width/2, y: buttonView.bounds.height/2)
        buttonView.addSubview(titleLabel)
        addSubview(buttonView)
    }
}

class FooterButtonView: UIView {}

extension UIView {
    func setBottomRoundCorner(with size: CGSize) {
        let maskPath = UIBezierPath(roundedRect: bounds,
                                    byRoundingCorners: [.bottomLeft, .bottomRight],
                                    cornerRadii: size)
        let maskLayer = CAShapeLayer()
        maskLayer.frame = bounds
        maskLayer.path = maskPath.cgPath
        layer.mask = maskLayer
    }
}
