//
//  BaseView.swift
//  NavigationModule
//
//  Created by Yamada Taku on 2018/06/29.
//  Copyright © 2018 Yamada Taku. All rights reserved.
//

import Foundation
import UIKit

struct FooterButtonConfigure {
    enum ButtonType {
        case single
        case double
        case none
    }

    let type: ButtonType
    let singleTitle: String?
    let doubleLeftTitle: String?
    let doubleRightTitle: String?
    let completion: (() -> ())?
    init(type: ButtonType = .single,
         singleTitle: String? = nil,
         doubleLeftTitle: String? = nil,
         doubleRightTitle: String? = nil,
         completion: (() -> ())? = nil) {
        self.type = type
        self.singleTitle = singleTitle
        self.doubleLeftTitle = doubleLeftTitle
        self.doubleRightTitle = doubleRightTitle
        self.completion = completion
    }
}

struct BaseViewComponent {
    // TODO: 作成するダイアログパターン
    /*
     ### ウォークスルー
     - ボタン1つ + 画像 (ボタン部分に余白のあるタイプ)

     ### アラート
     - タイトル(背景カラー指定可能) + メッセージ + ボタン(1-2個)
     - タイトル(背景カラー指定可能) + 画像 + ボタン(1-2個)

     ### アンケート
     - タイトル(背景カラー指定可能) + メッセージ + テキストフィールド + ボタン(1-2個)
     */
    enum ViewType {
        case walkthrough
        case alert
        case dialog
    }

    var viewType: ViewType
    var cornerRadius: CGFloat
    var shouldDisplayFooterView: Bool
    var footerButtonConfigure: FooterButtonConfigure
    var image: UIImage?

    init(viewType: ViewType = .walkthrough,
         cornerRadius: CGFloat = 10,
         shouldDisplayFooterView: Bool = true,
         footerButtonConfigure: FooterButtonConfigure,
         image: UIImage? = nil) {
        self.viewType = viewType
        self.cornerRadius = cornerRadius
        self.shouldDisplayFooterView = shouldDisplayFooterView
        self.footerButtonConfigure = footerButtonConfigure
        self.image = image
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
                     centerPosition: CGPoint, gesture: UITapGestureRecognizer? = nil) {
        var baseViewFrame = CGRect()
        switch component.viewType {
        case .dialog:
            baseViewFrame = CGRect(x: 0, y: 0, width: superViewSize.width/1.5,
                                   height: superViewSize.height/2.3)
        case .alert:
            baseViewFrame = CGRect(x: 0, y: 0, width: superViewSize.width/1.5,
                                   height: superViewSize.height/2)
        case .walkthrough:
            baseViewFrame = CGRect(x: 0, y: 0, width: superViewSize.width/1.3,
                                   height: superViewSize.height/1.8)
        }
        self.init(frame: baseViewFrame)
        center = centerPosition

        if let image = component.image {
            setImage(with: image)
        }
        setFooterView(type: component.footerButtonConfigure, cornerRadius: component.cornerRadius,
                      size: footerViewSize, gesture: gesture)
    }
    var footerViewSize: CGSize {
        return CGSize(width: bounds.width, height: bounds.height/6)
    }
    func setFooterView(type: FooterButtonConfigure,
                       cornerRadius: CGFloat, size: CGSize, gesture: UITapGestureRecognizer?) {
        let footerViewFrame = CGRect(x: 0, y: bounds.height - size.height, width: size.width, height: size.height)
        let footerView = FooterView(footerButtonType: type, frame: footerViewFrame,
                                    cornerRadius: cornerRadius, gesture: gesture)
        footerView.backgroundColor = UIColor.red
        footerView.setBottomRoundCorner(with: CGSize(width: cornerRadius, height: cornerRadius))
        addSubview(footerView)
    }
    func setImage(with image: UIImage) {
        let imageView = UIImageView(image:image)
        imageView.bounds.size = CGSize(width: bounds.width, height: bounds.height-footerViewSize.height)
        imageView.center.x = bounds.width/2
        imageView.center.y = (bounds.height-footerViewSize.height)/2
        imageView.contentMode = .scaleAspectFit
        addSubview(imageView)
    }
}

class FirstBaseView: BaseView {}
class LastBaseView: BaseView {}

class FooterView: UIView {
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    convenience init(footerButtonType: FooterButtonConfigure,
                     frame: CGRect, cornerRadius: CGFloat, gesture: UITapGestureRecognizer?) {
        self.init(frame: frame)
        setFooterButton(configure: footerButtonType, cornerRadius: cornerRadius, gesture: gesture)
    }
    func setFooterButton(configure: FooterButtonConfigure, cornerRadius: CGFloat,
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
            buttonView.backgroundColor = UIColor.white

            let titleLabel = UILabel()
            titleLabel.text = configure.singleTitle
            titleLabel.sizeToFit()
            titleLabel.center = CGPoint(x: buttonView.bounds.width/2, y: buttonView.bounds.height/2)
            buttonView.addSubview(titleLabel)
            addSubview(buttonView)

        case .double:
            let buttonSize = CGSize(width: bounds.width/2 - 20, height: bounds.height/2)
            let leftButtonView = FooterButtonView()
            if let gesture = gesture {
                leftButtonView.addGestureRecognizer(gesture)
            }
            leftButtonView.bounds.size = buttonSize
            leftButtonView.center = CGPoint(x: bounds.width/4, y: bounds.height/2)
            leftButtonView.layer.cornerRadius = cornerRadius
            leftButtonView.backgroundColor = UIColor.white

            let leftTitleLabel = UILabel()
            leftTitleLabel.text = configure.singleTitle
            leftTitleLabel.sizeToFit()
            leftTitleLabel.center = CGPoint(x: leftButtonView.bounds.width/2, y: leftButtonView.bounds.height/2)
            leftButtonView.addSubview(leftTitleLabel)
            addSubview(leftButtonView)

            let rightButtonView = FooterButtonView()
            if let gesture = gesture {
                rightButtonView.addGestureRecognizer(gesture)
            }
            rightButtonView.bounds.size = buttonSize
            rightButtonView.center = CGPoint(x: bounds.width*3/4, y: bounds.height/2)
            rightButtonView.backgroundColor = UIColor.black
            rightButtonView.layer.cornerRadius = cornerRadius
            rightButtonView.backgroundColor = UIColor.white

            let rightTitleLabel = UILabel()
            rightTitleLabel.text = configure.singleTitle
            rightTitleLabel.sizeToFit()
            rightTitleLabel.center = CGPoint(x: rightButtonView.bounds.width/2, y: rightButtonView.bounds.height/2)
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
