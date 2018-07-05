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

    @IBAction func popButton(_ sender: UIButton) {
        let popNavi = PopNavi()
        popNavi.configureOption.backgroundViewFradientType = .lemonGrape
        let buttonConfigure = FooterViewConfigure(type: .single, singleButtonTitle: "NEXT", singleButtonTextColor: UIColor.orange)
        let lastButtonConfigure = FooterViewConfigure(type: .single, singleButtonTitle: "OK", singleButtonTextColor: UIColor.orange)
        let firstViewComponent = BaseViewComponent(viewType: .walkthrough, footerViewConfigure: buttonConfigure, image: firstImage)
        let secondViewComponent = BaseViewComponent(viewType: .walkthrough, footerViewConfigure: buttonConfigure, image: secondImage)
        let thirdViewComponent = BaseViewComponent(viewType: .walkthrough, footerViewConfigure: lastButtonConfigure, image: thirdImage)
        popNavi.setBaseView(baseViewComponent: firstViewComponent, isLastView: false)
        popNavi.setBaseView(baseViewComponent: secondViewComponent, isLastView: false)
        popNavi.setBaseView(baseViewComponent: thirdViewComponent, isLastView: true)
        popNavi.configureNavigation()
        popNavi.slideUp(duration: 0.7)
        // TODO: 今後やること
        /*
         - アニメーションのテンプレート指定はBaseView.animationStyleなどのstructプロパティとして切り出す
         */
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
        var firstViewComponent = BaseViewComponent(viewType: .walkthrough, footerViewConfigure: buttonConfigure, image: blackFirstImage)
        firstViewComponent.baseViewColor = UIColor.black
        var secondViewComponent = BaseViewComponent(viewType: .walkthrough, footerViewConfigure: buttonConfigure, image: blackSecondImage)
        secondViewComponent.baseViewColor = UIColor.black
        var thirdViewComponent = BaseViewComponent(viewType: .walkthrough, footerViewConfigure: lastButtonConfigure, image: blackThirdImage)
        thirdViewComponent.baseViewColor = UIColor.black
        popNavi.setBaseView(baseViewComponent: firstViewComponent, isLastView: false)
        popNavi.setBaseView(baseViewComponent: secondViewComponent, isLastView: false)
        popNavi.setBaseView(baseViewComponent: thirdViewComponent, isLastView: true)
        popNavi.configureNavigation()
        popNavi.slideUp(duration: 0.7)
    }
    override func viewDidLoad() {
        super.viewDidLoad()
    }
}

