//
//  SCHomeTitleView.swift
//  圣才电子书
//
//  Created by 周磊 on 16/6/18.
//  Copyright © 2016年 周磊. All rights reserved.
//  首页导航栏

import UIKit


class SCHomeTitleView: UIView {

       // MARK: - 首页顶栏扫一扫
    lazy var homeRichScan:SCButton = {
        
        let homeRichScan = SCButton.init(type: UIButtonType.Custom)
        homeRichScan.setTitle("扫一扫", forState: UIControlState.Normal)
        homeRichScan.setTitleColor(RGB(213, g: 213, b: 213), forState: UIControlState.Normal)
        homeRichScan.setImage(SCIMAGE("首页顶栏扫一扫"), forState: UIControlState.Normal)
        return homeRichScan
    }()
  
    // MARK: - 首页顶部学友群
    lazy var homeSchoolmate:SCButton = {
        
        let homeSchoolmate = SCButton.init(type: UIButtonType.Custom)
        homeSchoolmate.setTitle("学友群", forState: UIControlState.Normal)
        homeSchoolmate.setTitleColor(RGB(213, g: 213, b: 213), forState: UIControlState.Normal)
        homeSchoolmate.setImage(SCIMAGE("首页顶部学友群图标"), forState: UIControlState.Normal)
        return homeSchoolmate
    }()
    
    
    // MARK: - 首页顶部搜索框
    lazy var homeSearchBox:UIImageView = {
        let homeSearchBox = UIImageView.init()
        homeSearchBox.image = SCIMAGE("login_edit_back")
        return homeSearchBox
    }()
    // MARK: - 首页顶部搜索框内容
    lazy var homeSearchBoxContent:UILabel = {
        let homeSearchBoxContent = UILabel.init()
        homeSearchBoxContent.text = "共有45204种电子书"
        homeSearchBoxContent.textColor = RGB(213, g: 213, b: 213)
        homeSearchBoxContent.font = SCFont(13)
        return homeSearchBoxContent
    }()
    
    // MARK: - 首页顶部搜索框录音按钮
    lazy var homeSearchBoxVoice:UIButton = {
        let homeSearchBoxVoice = UIButton.init(type: UIButtonType.Custom)
        homeSearchBoxVoice.setImage(SCIMAGE("001_1voice_03"), forState: UIControlState.Normal)
        return homeSearchBoxVoice
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        let bottomView = UIView.init()
        self.addSubview(bottomView)
        bottomView.snp.makeConstraints(closure: { (make) in
            make.left.bottom.right.equalTo(self).offset(0)
            make.top.equalTo(self).offset(20)
        })
        bottomView.addSubview(self.homeRichScan)
        self.homeRichScan.snp.makeConstraints(closure: { (make) in
            make.centerY.equalTo(bottomView.snp.centerY).offset(5)
            make.left.equalTo(bottomView).offset(0)
            make.height.width.equalTo(35)
        })
        bottomView.addSubview(self.homeSchoolmate)
        self.homeSchoolmate.snp.makeConstraints(closure: { (make) in
            make.centerY.equalTo(bottomView.snp.centerY).offset(0)
            make.right.equalTo(bottomView).offset(-5)
            make.height.width.equalTo(35)
        })
        
        bottomView.addSubview(self.homeSearchBox)
        self.homeSearchBox.snp.makeConstraints(closure: { (make) in
            make.centerY.equalTo(bottomView.snp.centerY).offset(0)
            make.left.equalTo(bottomView).offset(50)
            make.right.equalTo(bottomView).offset(-50)
            make.height.equalTo(30)
        })
        self.homeSearchBox.addSubview(self.homeSearchBoxContent)
        self.homeSearchBoxContent.snp.makeConstraints(closure: { (make) in
            make.centerY.equalTo(self.homeSearchBox.snp.centerY).offset(0)
            make.centerX.equalTo(self.homeSearchBox.snp.centerX).offset(0)
            
        })
        
        self.homeSearchBox.addSubview(self.homeSearchBoxVoice)
        self.homeSearchBoxVoice.snp.makeConstraints(closure: { (make) in
            make.centerY.equalTo(self.homeSearchBox.snp.centerY).offset(0)
            make.right.equalTo(self.homeSearchBox).offset(0)
            make.width.height.equalTo(30)
        })

    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
   
}
