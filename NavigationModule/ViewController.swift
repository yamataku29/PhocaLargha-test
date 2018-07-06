//
//  ViewController.swift
//  NavigationModule
//
//  Created by Yamada Taku on 2018/06/28.
//  Copyright © 2018 Yamada Taku. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    let firstImage = UIImage(named: "first_image")
    let secondImage = UIImage(named: "second_image")
    let thirdImage = UIImage(named: "third_image")
    let blackFirstImage = UIImage(named: "black_first_image")
    let blackSecondImage = UIImage(named: "black_second_image")
    let blackThirdImage = UIImage(named: "black_third_image")
    let blackFourthImage = UIImage(named: "black_fourth_image")

    @IBAction func inputMessageButton(_ sender: UIButton) {
        let popNavi = PopNavi()
        popNavi.configureOption.backgroundViewFradientType = .peachGrape
        popNavi.configureOption.shouldDisplayPageControl = false
        // TODO: テキストフィールド入力中のキーボードの操作処理を追加
        // TODO: フッターボタンのcompletionHandlerを実装
        // TODO: UIImageの有無でダイアログ高さ&タイトルラベル高さ&フッタービュー高さを変更する(resizeみたいなfunctionを入れるか)
        // NOTE: 👆画面サイズからダイアログの大きさを決定する仕様だが、コンポーネントの数によって大きさを決定した方がシンプルにかけそう(コンポーネントの大きさを決める)
        let buttonConfigure = FooterViewConfigure(type: .double, leftButtonTitle: "BACK",rightButtonTitle: "SUBMIT",
                                                  leftButtonColor: UIColor.gray, rightButtonColor: UIColor.purple,
                                                  leftButtonTextColor: UIColor.white, rightButtonTextColor: UIColor.white)
        let viewComponent = BaseViewComponent(viewType: .medium, footerViewConfigure:
            buttonConfigure, topTitleText: "Alert title text!", shouldDisplayMessageField: true, messageFieldPlaceholder: "Please input text here.")
        popNavi.setBaseView(baseViewComponent: viewComponent, isLastView: true)
        popNavi.configureNavigation()
        popNavi.slideUp(duration: 0.7)
    }

    @IBAction func alertDialogButton(_ sender: UIButton) {
        let popNavi = PopNavi()
        popNavi.configureOption.backgroundViewFradientType = .muddySoda
        popNavi.configureOption.shouldDisplayPageControl = false
        let buttonConfigure = FooterViewConfigure(type: .single, singleButtonTitle: "OK", singleButtonTextColor: UIColor.blue)
        let viewComponent = BaseViewComponent(viewType: .small, footerViewConfigure:
            buttonConfigure, image: firstImage, topTitleText: "Alert title text!")
        popNavi.setBaseView(baseViewComponent: viewComponent, isLastView: true)
        popNavi.configureNavigation()
        popNavi.slideUp(duration: 0.7)
    }

    @IBAction func popButton(_ sender: UIButton) {
        let popNavi = PopNavi()
        popNavi.configureOption.backgroundViewFradientType = .lemonGrape
        let buttonConfigure = FooterViewConfigure(type: .single, singleButtonTitle: "NEXT", singleButtonTextColor: UIColor.orange)
        let lastButtonConfigure = FooterViewConfigure(type: .single, singleButtonTitle: "OK", singleButtonTextColor: UIColor.orange)
        let firstViewComponent = BaseViewComponent(viewType: .large, footerViewConfigure: buttonConfigure, image: firstImage)
        let secondViewComponent = BaseViewComponent(viewType: .large, footerViewConfigure: buttonConfigure, image: secondImage)
        let thirdViewComponent = BaseViewComponent(viewType: .large, footerViewConfigure: lastButtonConfigure, image: thirdImage)
        popNavi.setBaseView(baseViewComponent: firstViewComponent, isLastView: false)
        popNavi.setBaseView(baseViewComponent: secondViewComponent, isLastView: false)
        popNavi.setBaseView(baseViewComponent: thirdViewComponent, isLastView: true)
        popNavi.configureNavigation()
        popNavi.slideUp(duration: 0.7)
    }

    @IBAction func blackNabiButton(_ sender: UIButton) {
        let popNavi = PopNavi()
        popNavi.configureOption.backgroundViewFradientType = .lemonGreenTea
        popNavi.configureOption.pageControlColor = UIColor.yellow
        var buttonConfigure = FooterViewConfigure(type: .single, singleButtonTitle: "NEXT", singleButtonTextColor: UIColor.yellow)
        buttonConfigure.backgroundColor = UIColor.black
        buttonConfigure.singleButtonColor = UIColor.black
        var lastButtonConfigure = FooterViewConfigure(type: .single, singleButtonTitle: "OK", singleButtonTextColor: UIColor.yellow)
        lastButtonConfigure.backgroundColor = UIColor.black
        lastButtonConfigure.singleButtonColor = UIColor.black
        var firstViewComponent = BaseViewComponent(viewType: .large, footerViewConfigure: buttonConfigure, image: blackFirstImage)
        firstViewComponent.baseViewColor = UIColor.black
        var secondViewComponent = BaseViewComponent(viewType: .large, footerViewConfigure: buttonConfigure, image: blackSecondImage)
        secondViewComponent.baseViewColor = UIColor.black
        var thirdViewComponent = BaseViewComponent(viewType: .large, footerViewConfigure: lastButtonConfigure, image: blackThirdImage)
        thirdViewComponent.baseViewColor = UIColor.black
        popNavi.setBaseView(baseViewComponent: firstViewComponent, isLastView: false)
        popNavi.setBaseView(baseViewComponent: secondViewComponent, isLastView: false)
        popNavi.setBaseView(baseViewComponent: thirdViewComponent, isLastView: true)
        popNavi.configureNavigation()
        popNavi.slideUp(duration: 0.7)
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        // TODO: 今後やること
        /*
         - アニメーションのテンプレート指定はBaseView.animationStyleなどのstructプロパティとして切り出す
         */
    }
}

