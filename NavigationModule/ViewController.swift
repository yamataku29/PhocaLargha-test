//
//  ViewController.swift
//  NavigationModule
//
//  Created by Yamada Taku on 2018/06/28.
//  Copyright © 2018 Yamada Taku. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBAction func popButton(_ sender: UIButton) {
        let popNavi = PopNavi()
        popNavi.setBaseView(sizeType: .small)
        popNavi.setBaseView(sizeType: .small)
        popNavi.configureNavigation()
        popNavi.isDismissibleForTap = true
        popNavi.slideUp(duration: 0.5)
        // TODO: 今後やること
        /*
         - ダイアログを複数用意した場合のページング処理を追加
         - PageControlコンポーネントを追加するオプションを実装
         - showDialogでもなんでもいいが、ダイアログを表示する際のメソッドの引数にBaseViewクラスをもたせる
         - BaseViewクラス内にダイアログのサイズやコンポーネントを指定する引数をもたせる
         - .isDismissibleForTapなどの個別の設定項目はPopNavi.configureなどのstructプロパティとして切り出す
         - アニメーションのテンプレート指定はPopNavi.animationStyleなどのstructプロパティとして切り出す
         */
    }

    override func viewDidLoad() {
        super.viewDidLoad()
    }
}

