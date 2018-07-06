//
//  BaseView.swift
//  NavigationModule
//
//  Created by Yamada Taku on 2018/06/29.
//  Copyright © 2018 Yamada Taku. All rights reserved.
//

import Foundation
import UIKit

struct FooterViewConfigure {
    enum ButtonType {
        case single
        case double
        case none
    }

    var type: ButtonType
    var singleButtonTitle: String?
    var leftButtonTitle: String?
    var rightButtonTitle: String?
    var singleButtonColor: UIColor?
    var leftButtonColor: UIColor?
    var rightButtonColor: UIColor?
    var singleButtonTextColor: UIColor?
    var leftButtonTextColor: UIColor?
    var rightButtonTextColor: UIColor?
    var backgroundColor: UIColor
    var buttonTextFont: UIFont?
    var completion: (() -> ())?

    init(type: ButtonType = .single,
         singleButtonTitle: String? = nil,
         leftButtonTitle: String? = nil,
         rightButtonTitle: String? = nil,
         singleButtonColor: UIColor? = .white,
         leftButtonColor: UIColor? = .white,
         rightButtonColor: UIColor? = .white,
         singleButtonTextColor: UIColor? = .black,
         leftButtonTextColor: UIColor? = .black,
         rightButtonTextColor: UIColor? = .black,
         backgroundColor: UIColor = .clear,
         buttonTextFont: UIFont? = UIFont.boldSystemFont(ofSize: 12),
         completion: (() -> ())? = nil) {
        self.type = type
        self.singleButtonTitle = singleButtonTitle
        self.leftButtonTitle = leftButtonTitle
        self.rightButtonTitle = rightButtonTitle
        self.singleButtonColor = singleButtonColor
        self.leftButtonColor = leftButtonColor
        self.rightButtonColor = rightButtonColor
        self.singleButtonTextColor = singleButtonTextColor
        self.leftButtonTextColor = leftButtonTextColor
        self.rightButtonTextColor = rightButtonTextColor
        self.backgroundColor = backgroundColor
        self.buttonTextFont = buttonTextFont
        self.completion = completion
    }
}

struct BaseViewComponent {
    // TODO: 作成するダイアログパターン
    /*
     - タイトル + メッセージ + ボタン(1-2個)
     - タイトル + テキストフィールド + ボタン(1-2個)
     */
    enum ViewType {
        case large
        case medium
        case small
    }

    var viewType: ViewType
    var cornerRadius: CGFloat
    var shouldDisplayFooterView: Bool
    var footerViewConfigure: FooterViewConfigure
    var image: UIImage?
    var baseViewColor: UIColor
    var topTitleText: String?
    var topTitleTextColor: UIColor
    var topTitleFont: UIFont
    var topTitleLabelHeight: CGFloat
    var shouldDisplayMessageField: Bool
    var messageFieldPlaceholder: String?

    init(viewType: ViewType,
         cornerRadius: CGFloat = 10,
         shouldDisplayFooterView: Bool = true,
         footerViewConfigure: FooterViewConfigure,
         image: UIImage? = nil,
         baseViewColor: UIColor = .white,
         topTitleText: String? = nil,
         topTitleTextColor: UIColor = .black,
         topTitleFont: UIFont = UIFont.boldSystemFont(ofSize: 20),
         topTitleLabelHeight: CGFloat = 60,
         shouldDisplayMessageField: Bool = false,
         messageFieldPlaceholder: String? = nil) {
        self.viewType = viewType
        self.cornerRadius = cornerRadius
        self.shouldDisplayFooterView = shouldDisplayFooterView
        self.footerViewConfigure = footerViewConfigure
        self.image = image
        self.baseViewColor = baseViewColor
        self.topTitleText = topTitleText
        self.topTitleTextColor = topTitleTextColor
        self.topTitleFont = topTitleFont
        self.topTitleLabelHeight = topTitleLabelHeight
        self.shouldDisplayMessageField = shouldDisplayMessageField
        self.messageFieldPlaceholder = messageFieldPlaceholder
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
        delegate = textFieldDelegate

        if let image = component.image {
            setImage(with: image, topTitleLabelHeight: component.topTitleLabelHeight)
        }
        backgroundColor = component.baseViewColor
        setFooterView(configure: component.footerViewConfigure, cornerRadius: component.cornerRadius,
                      size: footerViewSize, gesture: gesture)
        if let titleText = component.topTitleText {
            setTitleView(topTitleText: titleText, topTitleTextColor: component.topTitleTextColor,
                         topTitleFont: component.topTitleFont, topTitleLabelHeight: component.topTitleLabelHeight)
        }
        if component.shouldDisplayMessageField {
            let topTitleLabelHeight = component.topTitleText == nil ? 0 : component.topTitleLabelHeight
            setInputTextField(with: component.messageFieldPlaceholder, topTitleLabelHeight: topTitleLabelHeight)
        }
    }
    weak var delegate: UITextFieldDelegate?
    var footerViewSize: CGSize {
        return CGSize(width: bounds.width, height: bounds.height/6)
    }
    func setMessageTextView() {

    }
    func setInputTextField(with placeholder: String?, topTitleLabelHeight: CGFloat) {
        let textField = UITextField()
        let centerOffset = topTitleLabelHeight-footerViewSize.height
        let textFieldMargin: CGFloat = 40
        textField.bounds.size = CGSize(width: bounds.width-textFieldMargin,
                                       height: bounds.height/5)
        textField.center.x = bounds.width/2
        textField.center.y = bounds.height*3/5+centerOffset
        textField.borderStyle = .roundedRect
        textField.delegate = delegate
        textField.layer.borderColor = UIColor.lightGray.cgColor
        textField.layer.borderWidth = 1
        textField.layer.cornerRadius = 5
        textField.clearButtonMode = .always
        textField.returnKeyType = .done
        textField.placeholder = placeholder
        addSubview(textField)
    }
    func setTitleView(topTitleText: String, topTitleTextColor: UIColor, topTitleFont: UIFont, topTitleLabelHeight: CGFloat) {
        let titleLabel = UILabel()
        titleLabel.bounds.size = CGSize(width: bounds.width, height: topTitleLabelHeight)
        titleLabel.center = CGPoint(x: bounds.width/2, y: topTitleLabelHeight/2)
        titleLabel.text = topTitleText
        titleLabel.textColor = topTitleTextColor
        titleLabel.textAlignment = .center
        titleLabel.font = topTitleFont
        titleLabel.lineBreakMode = .byWordWrapping
        titleLabel.numberOfLines = 10
        addSubview(titleLabel)
    }
    func setFooterView(configure: FooterViewConfigure,
                       cornerRadius: CGFloat, size: CGSize, gesture: UITapGestureRecognizer?) {
        let footerViewFrame = CGRect(x: 0, y: bounds.height - size.height, width: size.width, height: size.height)
        let footerView = FooterView(footerViewType: configure, frame: footerViewFrame,
                                    cornerRadius: cornerRadius, gesture: gesture)
        footerView.backgroundColor = configure.backgroundColor
        footerView.setBottomRoundCorner(with: CGSize(width: cornerRadius, height: cornerRadius))
        addSubview(footerView)
    }
    func setImage(with image: UIImage, topTitleLabelHeight: CGFloat) {
        let imageView = UIImageView(image:image)
        let centerOffset = topTitleLabelHeight-footerViewSize.height
        imageView.bounds.size = CGSize(width: bounds.width, height: bounds.height-footerViewSize.height-topTitleLabelHeight)
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
    convenience init(footerViewType: FooterViewConfigure,
                     frame: CGRect, cornerRadius: CGFloat, gesture: UITapGestureRecognizer?) {
        self.init(frame: frame)
        setFooterButton(configure: footerViewType, cornerRadius: cornerRadius, gesture: gesture)
    }
    func setFooterButton(configure: FooterViewConfigure, cornerRadius: CGFloat,
                         gesture: UITapGestureRecognizer? = nil) {
        switch configure.type {
        case .single:
            let buttonView = FooterButtonView()
            if let gesture = gesture {
                buttonView.addGestureRecognizer(gesture)
            }
            buttonView.bounds.size = CGSize(width: bounds.width*2/3, height: bounds.height*3/5)
            buttonView.center = CGPoint(x: bounds.width/2, y: bounds.height/2)
            buttonView.layer.cornerRadius = cornerRadius
            buttonView.backgroundColor = configure.singleButtonColor

            let titleLabel = UILabel()
            titleLabel.text = configure.singleButtonTitle
            titleLabel.textColor = configure.singleButtonTextColor
            titleLabel.sizeToFit()
            titleLabel.font = configure.buttonTextFont
            titleLabel.textAlignment = .center
            titleLabel.center = CGPoint(x: buttonView.bounds.width/2, y: buttonView.bounds.height/2)
            buttonView.addSubview(titleLabel)
            addSubview(buttonView)

        case .double:
            let buttonSize = CGSize(width: bounds.width/2 - 30, height: bounds.height*3/5)
            let leftButtonView = FooterButtonView()
            if let gesture = gesture {
                leftButtonView.addGestureRecognizer(gesture)
            }
            leftButtonView.bounds.size = buttonSize
            leftButtonView.center = CGPoint(x: (bounds.width/4)+5, y: bounds.height/2)
            leftButtonView.layer.cornerRadius = cornerRadius
            leftButtonView.backgroundColor = configure.leftButtonColor

            let leftTitleLabel = UILabel()
            leftTitleLabel.text = configure.leftButtonTitle
            leftTitleLabel.sizeToFit()
            leftTitleLabel.center = CGPoint(x: leftButtonView.bounds.width/2, y: leftButtonView.bounds.height/2)
            leftTitleLabel.textColor = configure.leftButtonTextColor
            leftTitleLabel.font = configure.buttonTextFont
            leftTitleLabel.textAlignment = .center
            leftButtonView.addSubview(leftTitleLabel)
            addSubview(leftButtonView)

            let rightButtonView = FooterButtonView()
            if let gesture = gesture {
                rightButtonView.addGestureRecognizer(gesture)
            }
            rightButtonView.bounds.size = buttonSize
            rightButtonView.center = CGPoint(x: (bounds.width*3/4)-5, y: bounds.height/2)
            rightButtonView.backgroundColor = UIColor.black
            rightButtonView.layer.cornerRadius = cornerRadius
            rightButtonView.backgroundColor = configure.rightButtonColor

            let rightTitleLabel = UILabel()
            rightTitleLabel.text = configure.rightButtonTitle
            rightTitleLabel.sizeToFit()
            rightTitleLabel.center = CGPoint(x: rightButtonView.bounds.width/2, y: rightButtonView.bounds.height/2)
            rightTitleLabel.textColor = configure.rightButtonTextColor
            rightTitleLabel.font = configure.buttonTextFont
            rightTitleLabel.textAlignment = .center
            rightButtonView.addSubview(rightTitleLabel)
            addSubview(rightButtonView)

        case .none:
            break
        }
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
