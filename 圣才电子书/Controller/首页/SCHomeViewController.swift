//
//  SCHomeViewController.swift
//  圣才电子书
//
//  Created by 周磊 on 16/6/13.
//  Copyright © 2016年 周磊. All rights reserved.
//

import UIKit

class SCHomeViewController: SCBaseViewController {

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.addSubview(mainView)
        mainView.snp.makeConstraints { (make) in
            make.left.right.equalTo(self.view).offset(0)
            make.top.equalTo(self.view).offset(0)
            make.bottom.equalTo(self.view).offset(50)
        }
        
        self.showHUD()
        homeRequest.requestHomeDataSouce({ (successModelArray) in
            self.hideHUD()
            self.mainView.homeModelArray = successModelArray
            
            }) { (error) in
                self.hideHUD()
                self.showErrorHUDWithMessage("出错了")
        }
        
        
        self.mainView.MainHotSpotsSignal.subscribeNext { (value) in
            
            let model = value as! SCHomeHotSpotsModel
            let webView = SCWebViewController()
            webView.url = model.url!
            webView.titleLabel.text = model.title!
            self.navigationController?.pushViewController(webView, animated: true)
            
        }
        
        self.mainView.MainDiscoverSignal.subscribeNext { (value) in
            
            let model = value as! SCHomeDiscoverModel
            
            if model.tab_name! == "热点" {
                
                self.tabBarController?.selectedIndex = 2
                
            }else {
                
                let webView = SCWebViewController()
                webView.url = model.href_link!
                webView.titleLabel.text = model.tab_name!
                self.navigationController?.pushViewController(webView, animated: true)
            }
        }
        
        
        self.mainView.MainCategoryNavigationSignal.subscribeNext { (value) in
            
            let model = value as! SCHomeCategoryNavigationModel

            if model.name! == "电子书" {
                self.tabBarController?.selectedIndex = 1

            }else {
                
                print(model.name!)
            }
        }
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    
    lazy var mainView:SCHomeMainView = {
        var mainView = SCHomeMainView()
        return mainView
    }()
    
    
    // MARK: - SCMyCenterVM
    lazy var homeRequest:SCHomeVM = {
        let homeRequest = SCHomeVM()
        return homeRequest
    }()
    
    
}
