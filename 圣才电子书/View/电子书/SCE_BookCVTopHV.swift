//
//  SCE_BookCVTopHV.swift
//  SCDZS
//
//  Created by 周磊 on 16/7/1.
//  Copyright © 2016年 周磊. All rights reserved.
//

import UIKit

class SCE_BookCVTopHV: UICollectionReusableView {
    
    let totalNumMode = SCE_BookTotalNumMode()

    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        
        let topView = UIView()
        topView.backgroundColor = UIColor.whiteColor()
        self.addSubview(topView)
        topView.snp.makeConstraints { (make) in
            make.top.left.right.equalTo(self).offset(0)
            make.height.equalTo(60)
        }
        
        let centerView = UIView()
        centerView.backgroundColor = UIColor.whiteColor()
        self.addSubview(centerView)
        centerView.snp.makeConstraints { (make) in
            make.left.right.equalTo(self).offset(0)
            make.top.equalTo(topView.snp.bottom).offset(0)
            make.height.equalTo(40)
        }
        
        let line = UIView()
        line.backgroundColor = BgColor
        self.addSubview(line)
        line.snp.makeConstraints { (make) in
            make.left.right.equalTo(self).offset(0)
            make.top.equalTo(topView.snp.bottom).offset(1)
            make.height.equalTo(1)
        }
        
        
        let bottomView = UIView()
        bottomView.backgroundColor = BgColor
        self.addSubview(bottomView)
        bottomView.snp.makeConstraints { (make) in
            make.left.right.bottom.equalTo(self).offset(0)
            make.height.equalTo(40)
        }
        
        bottomView.addSubview(titleLabel)
        titleLabel.snp.makeConstraints { (make) in
            make.centerY.equalTo(bottomView.snp.centerY).offset(0)
            make.left.equalTo(self).offset(10)
            
        }
        centerView.addSubview(numberBooksLabel)
        numberBooksLabel.snp.makeConstraints { (make) in
            make.centerY.equalTo(centerView.snp.centerY).offset(0)
            make.centerX.equalTo(centerView.snp.centerX).offset(0)

        }
        
        
        topView.addSubview(e_BookButton)
        e_BookButton.snp.makeConstraints { (make) in
            make.left.equalTo(topView).offset(20)
            make.right.equalTo(topView).offset(-20)
            make.top.equalTo(topView).offset(10)
            make.bottom.equalTo(topView).offset(-10)
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    lazy var titleLabel:UILabel = {
        var titleLabel = UILabel()
        titleLabel.font = SCFont(17)
        titleLabel.textColor = UIColor.blackColor()
        titleLabel.textAlignment  = NSTextAlignment.Center
        return titleLabel
    }()
    
    lazy var numberBooksLabel:UILabel = {
        var numberBooksLabel = UILabel()
        numberBooksLabel.font = SCFont(15)
        numberBooksLabel.textColor = UIColor.blackColor()
        numberBooksLabel.textAlignment  = NSTextAlignment.Center
        
        var attributedStr = NSMutableAttributedString.init(string: "共57040种电子书，19418种视频，2592种题库")
        attributedStr.addAttribute(NSForegroundColorAttributeName, value: UIColor.redColor(), range: NSMakeRange(1, 5))
        attributedStr.addAttribute(NSForegroundColorAttributeName, value: UIColor.redColor(), range: NSMakeRange(11, 5))
        attributedStr.addAttribute(NSForegroundColorAttributeName, value: UIColor.redColor(), range: NSMakeRange(20, 4))
        numberBooksLabel.attributedText = attributedStr

        return numberBooksLabel
    }()
    
    lazy var e_BookButton:UIButton = {
       var e_BookButton = UIButton()
        e_BookButton.backgroundColor = RGB(34, g: 190, b: 10)
        e_BookButton.layer.masksToBounds = true
        e_BookButton.layer.cornerRadius = 5
        e_BookButton.setTitle("查看我的电子书（题库）", forState: UIControlState.Normal)
        e_BookButton.setTitleColor(UIColor.whiteColor(), forState: UIControlState.Normal)
        return e_BookButton
    }()
    
}
