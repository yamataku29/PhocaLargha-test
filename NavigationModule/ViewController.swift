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

    @IBAction func popButton(_ sender: UIButton) {
        let popNavi = PopNavi()
        let buttonConfigure = FooterViewConfigure(type: .single, singleButtonTitle: "NEXT")//, singleButtonTextColor: .orange)
        let lastButtonConfigure = FooterViewConfigure(type: .single, singleButtonTitle: "OK")
        let firstViewComponent = BaseViewComponent(footerViewConfigure: buttonConfigure, image: firstImage)
        let secondViewComponent = BaseViewComponent(footerViewConfigure: buttonConfigure, image: secondImage)
        let thirdViewComponent = BaseViewComponent(footerViewConfigure: lastButtonConfigure, image: thirdImage)
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

    override func viewDidLoad() {
        super.viewDidLoad()
    }
}

