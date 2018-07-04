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
        let buttonConfigure = FooterButtonConfigure(type: .single, singleTitle: "NEXT")
        let lastButtonConfigure = FooterButtonConfigure(type: .single, singleTitle: "OK")
        let baseViewComponent = BaseViewComponent(footerButtonConfigure: buttonConfigure, image: UIImage(named: "third_image"))
        let lastBaseViewComponent = BaseViewComponent(footerButtonConfigure: lastButtonConfigure)
        popNavi.setBaseView(baseViewComponent: baseViewComponent, isLastView: false)
        popNavi.setBaseView(baseViewComponent: baseViewComponent, isLastView: false)
        popNavi.setBaseView(baseViewComponent: baseViewComponent, isLastView: false)
        popNavi.setBaseView(baseViewComponent: lastBaseViewComponent, isLastView: true)
        popNavi.configureNavigation()
        popNavi.slideUp(duration: 0.5)
        // TODO: 今後やること
        /*
         - アニメーションのテンプレート指定はBaseView.animationStyleなどのstructプロパティとして切り出す
         */
    }

    override func viewDidLoad() {
        super.viewDidLoad()
    }
}

