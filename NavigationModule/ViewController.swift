//
//  ViewController.swift
//  NavigationModule
//
//  Created by Yamada Taku on 2018/06/28.
//  Copyright © 2018 Yamada Taku. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    let firstImage = UIImage(named: "first_image")!
    let secondImage = UIImage(named: "second_image")!
    let thirdImage = UIImage(named: "third_image")!
    let blackFirstImage = UIImage(named: "black_first_image")!
    let blackSecondImage = UIImage(named: "black_second_image")!
    let blackThirdImage = UIImage(named: "black_third_image")!
    let blackFourthImage = UIImage(named: "black_fourth_image")!

    @IBAction func popButton(_ sender: UIButton) {
        let popNavi = PopNavi()
        popNavi.configureOption.backgroundViewFradientType = .lemonGrape
        let completion = { [weak self] () -> Void in
            self?.alert()
        }
        popNavi.configureOption.completion = completion
        let topComponent = TopComponent(text: "Test!!!Test!!!Test!!!")
        let footerComponent = FooterComponent(buttonTitle: "NEXT", buttonTextColor: UIColor.orange)
        let lastFooterComponent = FooterComponent(buttonTitle: "OK", buttonTextColor: UIColor.orange)
        let firstViewComponent = BaseViewComponent(viewType: .small, topComponent: topComponent, footerComponent: footerComponent, image: firstImage)
        let secondViewComponent = BaseViewComponent(viewType: .medium, topComponent: topComponent, footerComponent: footerComponent, image: secondImage)
        let thirdViewComponent = BaseViewComponent(viewType: .large, topComponent: topComponent, footerComponent: lastFooterComponent, image: thirdImage)
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
        let topComponent = TopComponent(text: "Test!!!", textColor: .yellow)
        var footerComponent = FooterComponent(buttonTitle: "NEXT", buttonTextColor: UIColor.yellow)
        footerComponent.backgroundColor = UIColor.black
        footerComponent.buttonColor = UIColor.black
        var lastFooterComponent = FooterComponent(buttonTitle: "OK", buttonTextColor: UIColor.yellow)
        lastFooterComponent.backgroundColor = UIColor.black
        lastFooterComponent.buttonColor = UIColor.black
        var firstViewComponent = BaseViewComponent(viewType: .large, topComponent: topComponent, footerComponent: footerComponent, image: blackFirstImage)
        firstViewComponent.baseViewColor = UIColor.black
        var secondViewComponent = BaseViewComponent(viewType: .large, topComponent: topComponent, footerComponent: footerComponent, image: blackSecondImage)
        secondViewComponent.baseViewColor = UIColor.black
        var thirdViewComponent = BaseViewComponent(viewType: .large, topComponent: topComponent, footerComponent: lastFooterComponent, image: blackThirdImage)
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

    func alert() -> Void {
        let alert: UIAlertController = UIAlertController(title: "Complete!", message: "Please push \"OK\"", preferredStyle:  .alert)
        let defaultAction: UIAlertAction = UIAlertAction(title: "OK", style: .default, handler:{
            (action: UIAlertAction!) -> Void in
        })
        alert.addAction(defaultAction)
        present(alert, animated: true, completion: nil)
    }
}

