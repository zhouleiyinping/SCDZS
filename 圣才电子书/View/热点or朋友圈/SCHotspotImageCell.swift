
//
//  SCHotspotImageCell.swift
//  SCDZS
//
//  Created by 周磊 on 16/7/4.
//  Copyright © 2016年 周磊. All rights reserved.
//  三个图片的热点cell

import UIKit

class SCHotspotImageCell: SCHotspotBaseCell {

    var cellTalksModel :talksModel = talksModel() {
        
        didSet {
            
            titleLabel.text = cellTalksModel.productName!
            authorName.text = "\(cellTalksModel.nickName!) \(cellTalksModel.talkTime1!)"
            
              bgOneImageView.kf_setImageWithURL(NSURL(string: cellTalksModel.mediaImgList![0] as! String)!, placeholderImage: placeholderImage)
            bgTwoImageView.kf_setImageWithURL(NSURL(string: cellTalksModel.mediaImgList![1] as! String)!, placeholderImage: placeholderImage)
            bgThreeImageView.kf_setImageWithURL(NSURL(string: cellTalksModel.mediaImgList![2] as! String)!, placeholderImage: placeholderImage)
           
        }
    }
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setSubView()
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func setSubView() {
        
        self.contentView.addSubview(titleLabel)
        titleLabel.snp.makeConstraints { (make) in
            make.left.top.equalTo(self).offset(10)
            make.right.equalTo(self).offset(-10)
        }
        
        self.contentView.addSubview(authorName)
        authorName.snp.makeConstraints { (make) in
            make.left.equalTo(self).offset(10)
            make.bottom.equalTo(self).offset(-10)
        }
        
        self.contentView.addSubview(bgOneImageView)
        bgOneImageView.snp.makeConstraints { (make) in
            make.left.equalTo(self).offset(10)
            make.top.equalTo(titleLabel.snp.bottom).offset(10)
            make.width.equalTo((ScreenWidth-30)/3)
            make.height.equalTo(90)
            make.bottom.equalTo(self).offset(-30)
        }
        self.contentView.addSubview(bgTwoImageView)
        bgTwoImageView.snp.makeConstraints { (make) in
            make.left.equalTo(self).offset(10 + ((ScreenWidth-30)/3) + 5)
            make.top.equalTo(bgOneImageView.snp.top).offset(0)
            make.width.equalTo((ScreenWidth-30)/3)
            make.height.equalTo(90)
            make.bottom.equalTo(self).offset(-30)
        }
        self.contentView.addSubview(bgThreeImageView)
        bgThreeImageView.snp.makeConstraints { (make) in
            make.left.equalTo(self).offset(10 + (2*(((ScreenWidth-30)/3) + 5)))
            make.top.equalTo(titleLabel.snp.bottom).offset(10)
            make.width.equalTo((ScreenWidth-30)/3)
            make.height.equalTo(90)
            make.bottom.equalTo(self).offset(-30)
        }
        
    }
    
    lazy var bgOneImageView:UIImageView = {
        var bgImageView = UIImageView ()
        return bgImageView
    }()
    lazy var bgTwoImageView:UIImageView = {
        var bgImageView = UIImageView ()
        return bgImageView
    }()
    lazy var bgThreeImageView:UIImageView = {
        var bgImageView = UIImageView ()
        return bgImageView
    }()
}
