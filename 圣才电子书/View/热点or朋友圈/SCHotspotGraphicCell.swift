//
//  SCHotspotGraphicCell.swift
//  SCDZS
//
//  Created by 周磊 on 16/7/4.
//  Copyright © 2016年 周磊. All rights reserved.
//  一张图片的热点cell

import UIKit

class SCHotspotGraphicCell: SCHotspotBaseCell {
    
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setSubView()
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setSubView() {
        
        self.contentView.addSubview(bgImageView)
        bgImageView.snp.makeConstraints { (make) in
            make.top.equalTo(self).offset(10)
            make.width.equalTo(ScreenWidth/3)
            make.bottom.equalTo(self).offset(-10)
            make.right.equalTo(self).offset(-10)
        }
        
        self.contentView.addSubview(titleLabel)
        titleLabel.snp.makeConstraints { (make) in
            make.left.top.equalTo(self).offset(10)
            make.right.equalTo(bgImageView.snp.left).offset(-10)
        }
        
        self.contentView.addSubview(authorName)
        authorName.snp.makeConstraints { (make) in
            make.left.equalTo(self).offset(10)
            make.bottom.equalTo(self).offset(-10)
        }
        
    }

    var cellTalksModel :talksModel = talksModel() {
        
        didSet {
            
            bgImageView.kf_setImageWithURL(NSURL(string: cellTalksModel.mediaImgList![0] as! String)!, placeholderImage: UIImage(named: "mrt"))
            titleLabel.text = cellTalksModel.productName!
            authorName.text = "\(cellTalksModel.nickName!) \(cellTalksModel.talkTime1!)"

            
        }
    }
    
}
