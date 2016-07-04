//
//  SCHotspotLinkingCell.swift
//  SCDZS
//
//  Created by 周磊 on 16/7/4.
//  Copyright © 2016年 周磊. All rights reserved.
//

import UIKit

class SCHotspotLinkingCell: SCHotspotBaseCell {
    
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
    }
    
    var cellTalksModel :talksModel = talksModel() {
        
        didSet {
            
            titleLabel.text = cellTalksModel.productName!
            authorName.text = "\(cellTalksModel.nickName!) \(cellTalksModel.talkTime1!)"
            
        }
    }
}
