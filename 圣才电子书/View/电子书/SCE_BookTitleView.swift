//
//  SCE_BookTitleView.swift
//  SCDZS
//
//  Created by 周磊 on 16/7/1.
//  Copyright © 2016年 周磊. All rights reserved.
//  电子书导航栏

import UIKit

class SCE_BookTitleView: UIView {

    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.addSubview(titleLabel)
        titleLabel.snp.makeConstraints { (make) in
            make.centerX.equalTo(self.snp.centerX).offset(0)
            make.bottom.equalTo(self).offset(-10)
        }
        
        self.addSubview(searchImageButton)
        searchImageButton.snp.makeConstraints { (make) in
            make.bottom.equalTo(self).offset(-10)
            make.right.equalTo(self).offset(-15)
            make.width.height.equalTo(20)
        }
    }
    
    
    lazy var titleLabel:UILabel = {
       
        var titleLabel = UILabel.init()
        titleLabel.textColor  = UIColor.whiteColor()
        titleLabel.font = SCFont(16)
        titleLabel.textAlignment = NSTextAlignment.Center
        return titleLabel
        
    }()
    
    
    lazy var searchImageButton:UIButton = {
        
        var searchImageButton = UIButton.init()
        searchImageButton.setImage(UIImage.init(named: "head_search"), forState: UIControlState.Normal)
        return searchImageButton
    }()
    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    

}
