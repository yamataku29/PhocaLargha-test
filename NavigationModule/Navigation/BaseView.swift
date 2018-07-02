//
//  BaseView.swift
//  NavigationModule
//
//  Created by Yamada Taku on 2018/06/29.
//  Copyright © 2018 Yamada Taku. All rights reserved.
//

import Foundation
import UIKit

enum BaseViewType {
    case walkthrough
    case alert
    case dialog
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
}

class BaseView: UIView {
    private struct FooterViewSize {
        var height: CGFloat = 60
        var width: CGFloat
        init(width: CGFloat) {
            self.width = width
        }
    }
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    private var type: BaseViewType!
    private var footerViewSize: FooterViewSize!

    convenience init(type: BaseViewType, with superViewSize: CGSize, centerPosition: CGPoint) {
        var baseViewFrame = CGRect()
        switch type {
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
        self.footerViewSize = FooterViewSize(width: baseViewFrame.width)
        self.type = type
        center = centerPosition
    }
    func setFooterView(cornerRadius: CGFloat) {
        let footerView = FooterView(frame: CGRect(x: 0, y: bounds.height - footerViewSize.height,
                                              width: footerViewSize.width, height: footerViewSize.height))
        footerView.backgroundColor = UIColor.red
        footerView.setBottomRoundCorner(with: CGSize(width: cornerRadius, height: cornerRadius))
        addSubview(footerView)
    }
}

class FirstBaseView: BaseView {}
class FooterView: UIView {}

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
