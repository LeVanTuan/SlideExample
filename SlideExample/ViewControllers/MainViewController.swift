//
//  MainViewController.swift
//  CustomSlide
//
//  Created by Tuan LE on 8/14/17.
//  Copyright © 2017 Leo LE. All rights reserved.
//

import UIKit

class MainViewController: UIViewController {

    var leftVC: LeftViewController?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureNavigation()
        initProfileViewController()
        addGesture()
    }
    
    private func configureNavigation() {
        self.title = "Main"
        let leftButton = UIBarButtonItem(image: UIImage(named: "icon_menu"), style: .plain, target: self, action: #selector(self.menuAction(_ :)))
        self.navigationItem.leftBarButtonItem = leftButton
    }

    func menuAction(_ sender: Any) {
        showLeftViewController()
    }
    
    fileprivate func initProfileViewController() {
        let leftVC = LeftViewController(nibName: "LeftViewController", bundle: nil)
        if let frame = UIApplication.shared.windows.last?.frame {
            leftVC.resetWidth(parentWidth: frame.width)
            leftVC.shadowColor = UIColor(red: 46.0/255, green: 24.0/255, blue: 82.0/255, alpha: 0.7)
            leftVC.hasShadow = true
            UIApplication.shared.windows.last?.addSubview(leftVC.view)
        }
        self.leftVC = leftVC
    }
    
    fileprivate func addGesture() {
        let gesture = UITapGestureRecognizer(target: self, action: #selector(self.tapInSelf))
        self.view.addGestureRecognizer(gesture)
    }
    
    fileprivate func showLeftViewController() {
        leftVC?.expand()
    }
    
    func tapInSelf() {
        leftVC?.close()
    }
}
