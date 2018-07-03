//
//  PopNavi.swift
//  NavigationModule
//
//  Created by Yamada Taku on 2018/06/28.
//  Copyright © 2018 Yamada Taku. All rights reserved.
//

import UIKit

open class PopNavi: UIViewController, AppearAnimation, DimissAnimation {
    var configureOption = ConfigureOption()

    private var contentViews: [BaseView] = []
    private var backgroundView: UIView?
    private let scrollView = PagingScrollView()
    private let pageControl = UIPageControl()
    private var duration = 0.7

    // MARK: - Lifecycle method
    override open func viewDidLoad() {
        super.viewDidLoad()
        configureBackgroundView()
    }
    override open func viewWillLayoutSubviews() {
        if configureOption.isDismissibleForTap {
            scrollView.addGestureRecognizer(viewTapGesture)
        }
        if configureOption.shouldDisplayPageControl {
            if let presentingViewController = self.presentingViewController {
                let largeBaseViewHeight = presentingViewController.view.bounds.height/1.5
                pageControl.bounds.size = CGSize(width: 30, height: 15)
                pageControl.center.y = UIScreen.main.bounds.midY + largeBaseViewHeight/2 + 20
                pageControl.center.x = UIScreen.main.bounds.midX
                pageControl.numberOfPages = contentViews.count
                pageControl.currentPageIndicatorTintColor = UIColor.orange
                pageControl.currentPage = 0
                pageControl.isUserInteractionEnabled = false
                view.addSubview(pageControl)
            }
        }
    }

    // MARK: - Piublic property
    func setBaseView(baseViewComponent: BaseViewComponent, isLastView: Bool, baseViewColor: UIColor = .white) {
        var baseView = BaseView()

        if (contentViews.isEmpty) {
            baseView = FirstBaseView(component: baseViewComponent, with: view.bounds.size, centerPosition: view.center)
        } else if isLastView {
            baseView = LastBaseView(component: baseViewComponent, with: view.bounds.size,
                                        centerPosition: view.center, gesture: viewTapGesture)
        } else {
            baseView = BaseView(component: baseViewComponent, with: view.bounds.size, centerPosition: view.center)
        }

        baseView.backgroundColor = baseViewColor
        baseView.layer.cornerRadius = baseViewComponent.cornerRadius
        contentViews.append(baseView)
    }
    func configureNavigation() {
        generateScrollView()
        generateBaseView()
    }
    @objc func didTapButton() {
        scrollView.scrollToNext()
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
            self.scrollView.setContentOffset(CGPoint(x: 0, y: 0), animated: false)
            self.slideUp(with: self.contentViews, backgroundView: self.backgroundView,
                isBackgroundFadeIn: self.configureOption.isBackgroundFadeIn, duration: self.duration)
        })
    }
}

// MARK: - Private property
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
    func generateScrollView() {
        let scrollViewWidth = CGFloat(contentViews.count) * UIScreen.main.bounds.width
        scrollView.showsVerticalScrollIndicator = false
        scrollView.showsHorizontalScrollIndicator = false
        scrollView.bounds.size = UIScreen.main.bounds.size
        scrollView.contentSize = CGSize(width: scrollViewWidth, height: UIScreen.main.bounds.height)
        scrollView.center = view.center
        scrollView.isPagingEnabled = true
        scrollView.delegate = self

        view.addSubview(scrollView)
    }
    func generateBaseView() {
        contentViews.forEach { baseView in
            if (baseView is FirstBaseView) {
                baseView.center = CGPoint(x: UIScreen.main.bounds.midX, y: UIScreen.main.bounds.midY)
            } else {
                let index = contentViews.index(of: baseView)
                let centerX = scrollView.getContainerViewCenterX(index: index!)
                baseView.center = CGPoint(x: centerX, y: UIScreen.main.bounds.midY)
            }
            scrollView.addSubview(baseView)
        }
    }
    func configureBackgroundView() {
        backgroundView = UIView(frame: UIScreen.main.bounds)
        backgroundView!.backgroundColor = configureOption.backgroundColor
        backgroundView!.alpha = configureOption.backgroundAlpha
        view.addSubview(backgroundView!)
    }
    @objc func dismissWithAnimation() {
        slideDown(with: contentViews, presentingView: view, duration: duration, delegate: self)
    }
}

// MARK: - Delegate extensions
extension PopNavi: DimissAnimationDelegate {
    func endDismissAnimation() {
        dismiss(animated: false, completion: nil)
    }
}

extension PopNavi: UIGestureRecognizerDelegate {
    public func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldReceive touch: UITouch) -> Bool {
        return (touch.view == gestureRecognizer.view) ? true : false
    }
}

extension PopNavi: UIScrollViewDelegate {
    public func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if configureOption.shouldDisplayPageControl {
            pageControl.currentPage = (scrollView as! PagingScrollView).currentPageIndex
        }
    }
}
