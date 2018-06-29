//
//  PopNavi.swift
//  NavigationModule
//
//  Created by Yamada Taku on 2018/06/28.
//  Copyright © 2018 Yamada Taku. All rights reserved.
//

import UIKit

enum BaseViewSize {
    case small
    case medium
    case large
}

open class PopNavi: UIViewController, AppearAnimation, DimissAnimation {
    var backgroundColor = UIColor.black
    var backgroundAlpha: CGFloat = 0.5
    var isDimissAnimation: Bool = false
    var isBackgroundFadeIn: Bool = true
    var firstBaseView: FirstBaseView?
    var isDismissibleForTap: Bool = false {
        didSet {
            scrollView.addGestureRecognizer(viewTapGesture)
        }
    }
    private var contentViews: [BaseView] = []
    private let scrollView = PagingScrollView()
    private var backgroundView: UIView?
    private var duration = 0.7
    override open func viewDidLoad() {
        super.viewDidLoad()
    }

    func setBaseView(sizeType: BaseViewSize, baseViewColor: UIColor = .white) {
        if (firstBaseView == nil) {
            firstBaseView = FirstBaseView(sizeType: .medium, with: view.frame.size, centerPosition: view.center)
            firstBaseView?.backgroundColor = baseViewColor
            contentViews.append(firstBaseView!)
        } else {
            let baseView = BaseView(sizeType: .medium, with: view.frame.size, centerPosition: view.center)
            baseView.backgroundColor = baseViewColor
            contentViews.append(baseView)
        }
        configureNavigation()
    }
    func configureNavigation() {
        configureBackgroundView()

        let scrollViewWidth = CGFloat(contentViews.count) * UIScreen.main.bounds.width
        scrollView.frame.origin = CGPoint(x: 0, y: 0)
        scrollView.frame.size = CGSize(width: scrollViewWidth, height: UIScreen.main.bounds.height)
        view.addSubview(scrollView)

        contentViews.forEach { baseView in
            let button = UIButton()
            button.frame.size = CGSize(width: 80, height: 30)
            button.center = CGPoint(x: baseView.bounds.midX, y: baseView.bounds.midY)
            button.backgroundColor = UIColor.red
            button.addTarget(self, action: #selector(didTapButton), for: .touchUpInside)
            baseView.addSubview(button)

            let index = contentViews.index(of: baseView)
            let centerX = scrollView.getContainerViewCenterX(to: index!+1, screenWidth: UIScreen.main.bounds.width)
            baseView.center = CGPoint(x: centerX, y: UIScreen.main.bounds.midY)
            scrollView.addSubview(baseView)
        }
    }
    @objc func didTapButton() {
        print("🍺Button did tapped!!!")
    }
    func slideUp(duration: TimeInterval) {
        self.duration = duration
        guard let presentViewController = UIApplication.shared.keyWindow?.rootViewController else { return }
        var frontmostViewController = UIViewController()
        if presentViewController.childViewControllers.count == 0 {
            frontmostViewController = presentViewController
        } else {
            frontmostViewController = presentViewController
                .childViewControllers.first(where: { $0.presentingViewController == nil })!
        }
        modalPresentationStyle = .overCurrentContext
        frontmostViewController.present(self, animated: false, completion: { [weak self] in
            guard let `self` = self else { return }
            self.slideUp(with: self.firstBaseView, backgroundView: self.backgroundView,
                isBackgroundFadeIn: self.isBackgroundFadeIn, duration: self.duration)
        })
    }
}

extension PopNavi: DimissAnimationDelegate {
    func endDimissAnimation() {
        dismiss(animated: false, completion: nil)
    }
}

extension PopNavi: AccessibleProperty {}

private extension PopNavi {
    var screenFrame: CGRect {
        return UIScreen.main.bounds
    }
    var viewTapGesture: UITapGestureRecognizer {
        let gesture = UITapGestureRecognizer(target: self, action:#selector(dismissWithAnimation))
        gesture.cancelsTouchesInView = false
        gesture.delegate = self
        return gesture
    }
    @objc func dismissWithAnimation() {
        slideDown(with: firstBaseView, backgroundView: backgroundView, duration: duration, delegate: self)
    }
    func configureBackgroundView() {
        backgroundView = UIView(frame: UIScreen.main.bounds)
        backgroundView!.backgroundColor = backgroundColor
        backgroundView!.alpha = backgroundAlpha
        view.addSubview(backgroundView!)
    }
}

extension PopNavi: UIGestureRecognizerDelegate {
    public func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldReceive touch: UITouch) -> Bool {
        return (touch.view == gestureRecognizer.view) ? true : false
    }
}

class BaseView: UIView {
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
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
        center = centerPosition
    }
}

class FirstBaseView: BaseView {}

class PagingScrollView: UIScrollView {
    func getContainerViewCenterX(to index: Int, screenWidth: CGFloat) -> CGFloat {
        let maxIndex = Int(frame.width/screenWidth)
        let scrollToPositionX = frame.width * CGFloat(index/maxIndex)
        return scrollToPositionX/2
    }
    func scroll(viewFrame: CGRect, currentX: CGFloat) {
        let currentIndex = Int(viewFrame.width/currentX)
        let offset = CGPoint(x: pagingOffsetX(to: currentIndex+1, pagingWidth: viewFrame.width), y: 0)
        setContentOffset(offset, animated: true)
    }
    private func pagingOffsetX(to index: Int, pagingWidth: CGFloat) -> CGFloat {
        return CGFloat(index)*pagingWidth
    }
}
