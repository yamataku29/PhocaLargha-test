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
        popNavi.setBaseView(sizeType: .medium)
        popNavi.isDismissibleForTap = true
        popNavi.modalPresentationStyle = .overCurrentContext
        present(popNavi, animated: false, completion: nil)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
    }
}

