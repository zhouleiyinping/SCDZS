//
//  SCBaseViewController.swift
//  圣才电子书
//
//  Created by 周磊 on 16/6/17.
//  Copyright © 2016年 周磊. All rights reserved.
//

import UIKit
import SnapKit

// MARK: - 入栈类型
enum BaseLoadType {
    case BasePushType //push
    case BasePresentType  //Present
}

class SCBaseViewController: UIViewController {

    var loadType = BaseLoadType.BasePushType
    
    // MARK: - titleView
    lazy var titleView:UIView = {
        let titleView = UIView.init()
        titleView.backgroundColor = RGB(217, g: 40, b: 53)
        
        let bottomView = UIView.init()
        titleView.addSubview(bottomView)
        bottomView.snp.makeConstraints(closure: { (make) in
            make.left.bottom.right.equalTo(titleView).offset(0)
            make.top.equalTo(titleView).offset(20)
        })
        
        bottomView.addSubview(self.titleLabel)
        self.titleLabel.snp.makeConstraints(closure: { (make) in
            make.centerY.equalTo(bottomView.snp.centerY).offset(0)
            make.centerX.equalTo(bottomView.snp.centerX).offset(0)
        })
        
        bottomView.addSubview(self.backBtn)
        self.backBtn.snp.makeConstraints(closure: { (make) in
            make.centerY.equalTo(bottomView.snp.centerY).offset(0)
            make.left.equalTo(bottomView).offset(0)
            make.width.equalTo(60)
            make.height.equalTo(44)
        })
        bottomView.addSubview(self.homeBtn)
        self.homeBtn.snp.makeConstraints(closure: { (make) in
            make.centerY.equalTo(bottomView.snp.centerY).offset(0)
            make.right.equalTo(bottomView).offset(-10)
            make.width.equalTo(20)
            make.height.equalTo(20)
        })
        
        bottomView.addSubview(self.searchBtn)
        self.searchBtn.snp.makeConstraints(closure: { (make) in
            make.centerY.equalTo(bottomView.snp.centerY).offset(0)
            make.right.equalTo(self.homeBtn.snp.left).offset(-10)
            make.width.equalTo(20)
            make.height.equalTo(20)
        })
        
        
        return titleView
    }()

    // MARK: - titleView
    lazy var titleLabel:UILabel = {
        
        let titleLabel = UILabel()
        titleLabel.font = SCFont(16)
        titleLabel.backgroundColor = UIColor.clearColor()
        titleLabel.textColor = UIColor.whiteColor()
        titleLabel.textAlignment = NSTextAlignment.Center
        return titleLabel
    }()

    /// 返回按钮
    lazy var backBtn:UIButton = {
        let backBtn = UIButton(type: UIButtonType.Custom)
        backBtn.setImage(UIImage(named: "yw_nav_button_arrow.png"), forState: .Normal)
        backBtn.setTitle("返回", forState: UIControlState.Normal)
        backBtn.setTitleColor(UIColor.whiteColor(), forState: UIControlState.Normal)
        backBtn.titleLabel?.font = SCFont(16)
        backBtn.addTarget(self, action: #selector(SCBaseViewController.clickBack), forControlEvents: UIControlEvents.TouchUpInside)
        return backBtn
    }()
    
    /// 首页按钮
    lazy var homeBtn:UIButton = {
        let homeBtn = UIButton(type: UIButtonType.Custom)
        homeBtn.setImage(UIImage(named: "mainView"), forState: .Normal)
        homeBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignment.Right
        homeBtn.addTarget(self, action: #selector(SCBaseViewController.clickMainView), forControlEvents: UIControlEvents.TouchUpInside)

        return homeBtn
    }()
    /// 搜索按钮
    lazy var searchBtn:UIButton = {
        let searchBtn = UIButton(type: UIButtonType.Custom)
        searchBtn.setImage(UIImage(named: "head_search"), forState: .Normal)
        searchBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignment.Right
        searchBtn.addTarget(self, action: #selector(SCBaseViewController.clickSearch), forControlEvents: UIControlEvents.TouchUpInside)
        return searchBtn
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.navigationController?.setToolbarHidden(true, animated: true)
        //隐藏系统的导航栏
        self.navigationController?.navigationBarHidden = true
        self.view.addSubview(self.titleView)
        self.titleView.snp.makeConstraints { (make) in
            make.top.left.right.equalTo(self.view).offset(0)
            make.height.equalTo(NavigationH)
        }
                
    }
    
    func clickBack() {
        
        if self.loadType ==  BaseLoadType.BasePushType{
            self.navigationController?.popViewControllerAnimated(true)
        }else {
            self.navigationController?.dismissViewControllerAnimated(true, completion: nil)
        }
    }
    
    func clickMainView() {
        self.navigationController?.popToRootViewControllerAnimated(true)
    }
    func clickSearch() {
        
        SCLog("点击了搜索")
    }
    
    
}

