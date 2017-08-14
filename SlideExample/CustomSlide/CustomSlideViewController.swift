//
//  CustomSlideViewController.swift
//  CustomSlide
//
//  Created by Tuan LE on 8/14/17.
//  Copyright © 2017 Leo LE. All rights reserved.
//

import UIKit

class CustomSlideViewController: UIViewController {
    
    var animatedTime: TimeInterval = 0.3
    var shadowColor: UIColor = UIColor.darkGray
    var hasShadow: Bool = false {
        didSet {
            updateShadow()
        }
    }
    var parentWidth: CGFloat = UIScreen.main.bounds.width
    var spaceLength: CGFloat = 65 {
        didSet {
            resetWidth(parentWidth: parentWidth)
        }
    }
    fileprivate var maxExpandCenter: CGFloat!
    var isClosed: Bool = true
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.alpha = 0.0
        addGesture()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if view.frame.width == parentWidth {
            resetWidth(parentWidth: parentWidth)
            if isClosed {
                close()
            } else {
                expand()
            }
        }
    }
    
    public func resetWidth(parentWidth: CGFloat) {
        var frame = self.view.frame
        frame.size.width = parentWidth - spaceLength
        frame.origin.x = -frame.size.width
        self.view.frame = frame
        maxExpandCenter = frame.size.width / 2.0
    }
}

//MARK: - Configure UIs
extension CustomSlideViewController {
    //MARK: Shadow
    fileprivate func updateShadow() {
        if hasShadow {
            showShadow()
        } else {
            removeShadow()
        }
    }
    
    fileprivate func showShadow() {
        let radius: CGFloat = self.view.frame.width / 2.0
        let shadowPath = UIBezierPath(rect: CGRect(x: 0,
                                                   y: 0,
                                                   width: 2.1 * radius,
                                                   height: self.view.frame.height))
        
        self.view.layer.cornerRadius = 2
        self.view.layer.shadowColor = shadowColor.cgColor
        self.view.layer.shadowOffset = CGSize(width: 0.5, height: 0.4)
        self.view.layer.shadowOpacity = 0.5
        self.view.layer.shadowRadius = 5.0 //Here your control your blur
        self.view.layer.masksToBounds =  false
        self.view.layer.shadowPath = shadowPath.cgPath
    }
    
    fileprivate func removeShadow() {
        self.view.layer.shadowOpacity = 0.0
    }
}

//MARK: - UIPanGestureRecognizer
extension CustomSlideViewController {
    fileprivate func addGesture() {
        let panGesture = UIPanGestureRecognizer(target: self,
                                                action: #selector(CustomSlideViewController.panInSelf(_ :)))
        panGesture.maximumNumberOfTouches = 1
        self.view.addGestureRecognizer(panGesture)
    }
    
    func panInSelf(_ gesture: UIPanGestureRecognizer) {
        if gesture.state == .changed { //moving
            var center = view.center
            let translation = gesture.translation(in: view)
            let x = center.x + translation.x
            if x > maxExpandCenter {
                center.x = maxExpandCenter
            } else {
                center.x = x
            }
            gesture.view?.center = center
            gesture.setTranslation(CGPoint.zero, in: view)
        }
        
        if gesture.state == .ended || gesture.state == .cancelled {
            let center = view.center
            if center.x > 0 {
                expand(false)
            } else {
                close(false)
            }
        }
        
    }
}

//MARK: - Collapse
extension CustomSlideViewController {
    public func expand(_ isChangeAlpha: Bool = true) {
        var frame = view.frame
        frame.origin.x = 0
        if isChangeAlpha {self.view.alpha = 0.0}
        UIView.animate(withDuration: animatedTime,
                       delay: 0.0,
                       options: .transitionFlipFromLeft,
                       animations: {[unowned self] in
            self.view.frame = frame
            if isChangeAlpha {self.view.alpha = 1.0}
            }, completion: nil)
        if hasShadow {
            showShadow()
        }
        isClosed = false
    }
    
    public func close(_ isChangeAlpha: Bool = true) {
        var frame = view.frame
        frame.origin.x = -frame.size.width
        if isChangeAlpha {self.view.alpha = 1.0}
        UIView.animate(withDuration: animatedTime,
                       delay: 0.0,
                       options: .transitionFlipFromRight,
                       animations: {[unowned self] in
            self.view.frame = frame
            if isChangeAlpha {self.view.alpha = 0.0}
            }, completion: nil)
        removeShadow()
        isClosed = true
    }
    
}
