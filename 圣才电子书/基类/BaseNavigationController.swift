//
//  BaseNavigationController.swift
//  PDD
//
//  Created by 周磊 on 16/3/15.
//  Copyright © 2016年 ZL. All rights reserved.
//

import UIKit

class BaseNavigationController: LCPanNavigationController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    /**重写push方法*/
    override func pushViewController(viewController: UIViewController, animated: Bool) {
        if childViewControllers.count > 0 {
            UINavigationBar.appearance().backItem?.hidesBackButton = false
            viewController.hidesBottomBarWhenPushed = true

        }
        super.pushViewController(viewController, animated: animated)
    }
    
}
