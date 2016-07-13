//
//  SCHomeHeaderView.swift
//  SCDZS
//
//  Created by 周磊 on 16/7/8.
//  Copyright © 2016年 周磊. All rights reserved.
//  headerView

import UIKit

class integrationView: UIView {
    
    lazy var imageView:UIImageView = {
        var imageView  = UIImageView()
        return imageView
    }()
    
    lazy var titleLabel:UILabel = {
        var titleLabel  = UILabel()
        titleLabel.textColor = RGB(122, g: 125, b: 130)
        titleLabel.font  = SCFont(11)
        return titleLabel
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.addSubview(imageView)
        self.addSubview(titleLabel)
        titleLabel.snp.makeConstraints { (make) in
            make.centerX.equalTo(self.snp.centerX).offset(0)
            make.bottom.equalTo(self).offset(0)
        }
        
        imageView.snp.makeConstraints { (make) in
            make.centerX.equalTo(self.snp.centerX).offset(0)
            make.bottom.equalTo(titleLabel.snp.top).offset(-2)
            make.top.equalTo(self).offset(0)
            make.height.equalTo(18)
            make.width.equalTo(18)
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}


class SCHomeHeaderView: UIView {

    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.addSubview(self.homeRichScan)
        self.homeRichScan.snp.makeConstraints(closure: { (make) in
            make.centerY.equalTo(self.snp.centerY).offset(0)
            make.left.equalTo(self).offset(10)
            make.height.width.equalTo(35)
        })
        self.addSubview(self.homeSchoolmate)
        self.homeSchoolmate.snp.makeConstraints(closure: { (make) in
            make.centerY.equalTo(self.snp.centerY).offset(0)
            make.right.equalTo(self).offset(-10)
            make.height.width.equalTo(35)
        })
        
        self.addSubview(self.homeSearchBox)
        self.homeSearchBox.snp.makeConstraints(closure: { (make) in
            make.centerY.equalTo(self.snp.centerY).offset(0)
            make.left.equalTo(self).offset(50)
            make.right.equalTo(self).offset(-50)
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

    var homeNavigationModelArray = [SCHomeNavigationModel]() {
        
        didSet {
            
            if homeNavigationModelArray.count > 0 {
                let navigationModel = homeNavigationModelArray[0]
                homeRichScan.titleLabel.text  = navigationModel.tab_name!
                homeRichScan.imageView.kf_setImageWithURL(NSURL(string: navigationModel.tab_icon!)!, placeholderImage: placeholderImage)
            }
            
            if homeNavigationModelArray.count > 1 {
                let navigationModel = homeNavigationModelArray[2]
                homeSchoolmate.titleLabel.text  = navigationModel.tab_name!
                homeSchoolmate.imageView.kf_setImageWithURL(NSURL(string: navigationModel.tab_icon!)!, placeholderImage: placeholderImage)
            }

        }
    }
    
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
        homeSearchBoxVoice.addTarget(self, action: #selector(SCHomeHeaderView.clickVoice), forControlEvents: UIControlEvents.TouchUpInside)
        return homeSearchBoxVoice
    }()

    // MARK: - 首页顶栏扫一扫
    lazy var homeRichScan:integrationView = {
        let homeRichScan = integrationView()
        return homeRichScan
    }()
    
    // MARK: - 首页顶部学友群
    lazy var homeSchoolmate:integrationView = {
        let homeSchoolmate = integrationView()
        return homeSchoolmate
    }()
    

    func clickVoice() {
        
        SCLog("点击了录音")
    }
    
    
}
