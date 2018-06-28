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

open class PopNavi: UIViewController {
    var backgroundColor = UIColor.black
    var backgroundAlpha: CGFloat = 0.5
    var isDimissAnimation: Bool = false
    private var contentViews: [BaseView] = []
    private let scrollView = PagingScrollView()

    override open func viewDidLoad() {
        super.viewDidLoad()
        configureBackgroundView()
    }

    func setBaseView(sizeType: BaseViewSize, baseViewColor: UIColor = .white) {
        let baseView = BaseView(sizeType: .medium, with: view.frame.size, centerPosition: view.center)
        baseView.backgroundColor = baseViewColor
        contentViews.append(baseView)

        let scrollViewWidth = CGFloat(contentViews.count) * UIScreen.main.bounds.width
        scrollView.frame.origin = CGPoint(x: 0, y: 0)
        scrollView.frame.size = CGSize(width: scrollViewWidth, height: UIScreen.main.bounds.height)
        view.addSubview(scrollView)

        contentViews.forEach { baseView in
            let index = contentViews.index(of: baseView)
            let centerX = scrollView.getContainerViewCenterX(to: index!+1, screenWidth: UIScreen.main.bounds.width)
            baseView.center = CGPoint(x: centerX, y: UIScreen.main.bounds.midY)
            scrollView.addSubview(baseView)
        }
    }
}
extension PopNavi: AccessibleProperty {}
extension PopNavi: AppearAnimation {
    func slideUp() {
    }
    func slideUpWithBound() {
    }
    func centerZoomIn() {
    }
}

private extension PopNavi {
    var screenFrame: CGRect {
        return UIScreen.main.bounds
    }
    var viewTapGesture: UITapGestureRecognizer {
        return UITapGestureRecognizer(target: self, action:#selector(dismissPopNavi))
    }
    @objc func dismissPopNavi() {
        dismiss(animated: isDimissAnimation, completion: nil)
    }
    func configureBackgroundView() {
        let backgroundView = UIView(frame: UIScreen.main.bounds)
        backgroundView.backgroundColor = backgroundColor
        backgroundView.alpha = backgroundAlpha
        view.addSubview(backgroundView)
    }
}

extension UIView {
    func resizeFrame(type: BaseViewSize, point: CGPoint, superViewSize: CGSize) {
        switch type {
        case .small:
            self.frame = CGRect(x: point.x, y: point.y,
                          width: superViewSize.width/1.5, height: superViewSize.height/2.5)
        case .medium:
            self.frame = CGRect(x: point.x, y: point.y,
                          width: superViewSize.width/1.3, height: superViewSize.height/2)
        case .large:
            self.frame = CGRect(x: point.x, y: point.y,
                          width: superViewSize.width/1.1, height: superViewSize.height/1.5)
        }
    }
}

class BaseView: UIView {
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUp()
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
    func setUp() {
    }
}

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
