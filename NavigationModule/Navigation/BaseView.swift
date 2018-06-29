//
//  BaseView.swift
//  NavigationModule
//
//  Created by Yamada Taku on 2018/06/29.
//  Copyright © 2018 Yamada Taku. All rights reserved.
//

import Foundation
import UIKit

enum BaseViewSize {
    case small
    case medium
    case large
}

struct BaseViewComponent {
    // NOTE: デザイン重要 & 用途を意識したコンポーネント及びデザインにする
    // TODO: サイズによって最適なコンポーネントのレイアウトが変わるため、それぞれのサイズごとのデザインを作成してから着手する
    /* 用途
     - ウォークスルー
       - 画像
       - テキスト(TOP/CENTER/BOTTOM)
       - ボタン(縦/横)
     - アラート
       - テキスト
       - ボタン(縦/横)
     - テキスト入力
       - テキスト
       - テキストフィールド
       - ボタン(縦/横)
       - テキスト&テキストフィールドのセット(縦並び/横並び)
     */
}

class BaseView: UIView {
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    var sizeType: BaseViewSize!
    convenience init(sizeType: BaseViewSize, with superViewSize: CGSize, centerPosition: CGPoint) {
        var baseViewFrame = CGRect()
        switch sizeType {
        case .small:
            baseViewFrame = CGRect(x: 0, y: 0,
                                   width: superViewSize.width/1.5, height: superViewSize.height/2.5)
        case .medium:
            baseViewFrame = CGRect(x: 0, y: 0,
                                   width: superViewSize.width/1.3, height: superViewSize.height/2)
        case .large:
            baseViewFrame = CGRect(x: 0, y: 0,
                                   width: superViewSize.width/1.1, height: superViewSize.height/1.5)
        }
        self.init(frame: baseViewFrame)
        self.sizeType = sizeType
        center = centerPosition
    }
}

class FirstBaseView: BaseView {}
