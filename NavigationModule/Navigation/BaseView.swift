//
//  BaseView.swift
//  NavigationModule
//
//  Created by Yamada Taku on 2018/06/29.
//  Copyright © 2018 Yamada Taku. All rights reserved.
//

import Foundation
import UIKit

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
    enum FooterButtonType {
        case single
        case double
        case none
    }
    typealias FooterButtonObject = (type: FooterButtonType, completion: (() -> ())?)

    var viewType: ViewType
    var cornerRadius: CGFloat
    var shouldDisplayFooterView: Bool
    var footerButtonType: FooterButtonType
    var footerButtonObject: FooterButtonObject

    init(viewType: ViewType = .walkthrough,
         cornerRadius: CGFloat = 10,
         shouldDisplayFooterView: Bool = true,
         footerButtonType: FooterButtonType = .single,
         footerButtonObject: FooterButtonObject = (type: .single, completion: nil)) {
        self.viewType = viewType
        self.cornerRadius = cornerRadius
        self.shouldDisplayFooterView = shouldDisplayFooterView
        self.footerButtonType = footerButtonType
        self.footerButtonObject = footerButtonObject
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

        setFooterView(type: component.footerButtonType, cornerRadius: component.cornerRadius,
                      size: CGSize(width: bounds.width, height: bounds.height/6), gesture: gesture)
    }
    func setFooterView(type: BaseViewComponent.FooterButtonType,
                       cornerRadius: CGFloat, size: CGSize, gesture: UITapGestureRecognizer?) {
        let footerViewFrame = CGRect(x: 0, y: bounds.height - size.height, width: size.width, height: size.height)
        let footerView = FooterView(footerButtonType: type, frame: footerViewFrame,
                                    cornerRadius: cornerRadius, gesture: gesture)
        footerView.backgroundColor = UIColor.red
        footerView.setBottomRoundCorner(with: CGSize(width: cornerRadius, height: cornerRadius))
        addSubview(footerView)
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
    convenience init(footerButtonType: BaseViewComponent.FooterButtonType,
                     frame: CGRect, cornerRadius: CGFloat, gesture: UITapGestureRecognizer?) {
        self.init(frame: frame)
        setFooterButton(type: footerButtonType, cornerRadius: cornerRadius, gesture: gesture)
    }
    func setFooterButton(type: BaseViewComponent.FooterButtonType, cornerRadius: CGFloat,
                         gesture: UITapGestureRecognizer? = nil) {
        switch type {
        case .single:
            let buttonView = FooterButtonView()
            if let gesture = gesture {
                buttonView.addGestureRecognizer(gesture)
            }
            buttonView.bounds.size = CGSize(width: bounds.width*2/3, height: bounds.height*3/5)
            buttonView.center = CGPoint(x: bounds.width/2, y: bounds.height/2)
            buttonView.backgroundColor = UIColor.black
            buttonView.layer.cornerRadius = cornerRadius
            addSubview(buttonView)

        case .double:
            let buttonSize = CGSize(width: bounds.width/2 - 20, height: bounds.height/2)
            let leftButtonView = FooterButtonView()
            if let gesture = gesture {
                leftButtonView.addGestureRecognizer(gesture)
            }
            leftButtonView.bounds.size = buttonSize
            leftButtonView.center = CGPoint(x: bounds.width/4, y: bounds.height/2)
            leftButtonView.backgroundColor = UIColor.black
            leftButtonView.layer.cornerRadius = cornerRadius
            addSubview(leftButtonView)

            let rightButtonView = FooterButtonView()
            if let gesture = gesture {
                rightButtonView.addGestureRecognizer(gesture)
            }
            rightButtonView.bounds.size = buttonSize
            rightButtonView.center = CGPoint(x: bounds.width*3/4, y: bounds.height/2)
            rightButtonView.backgroundColor = UIColor.black
            rightButtonView.layer.cornerRadius = cornerRadius
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
