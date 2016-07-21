//
//  SCE_BookClassifiedCell.swift
//  SCDZS
//
//  Created by 周磊 on 16/7/19.
//  Copyright © 2016年 周磊. All rights reserved.
//

import UIKit

class SCE_BookClassifiedCell: UITableViewCell {

    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        self.addSubview(frontImageView)
        self.addSubview(titleLabel)
        self.addSubview(arrowImageView)
        frontImageView.snp.makeConstraints { (make) in
            make.centerY.equalTo(self.snp.centerY).offset(0)
            make.left.equalTo(self).offset(10)
            make.width.height.equalTo(5)
        }
        
        arrowImageView.snp.makeConstraints { (make) in
            make.centerY.equalTo(self.snp.centerY).offset(0)
            make.right.equalTo(self).offset(-20)
            make.width.height.equalTo(10)
        }
        
        titleLabel.snp.makeConstraints { (make) in
            make.centerY.equalTo(self.snp.centerY).offset(0)
            make.left.equalTo(frontImageView.snp.right).offset(10)
            make.right.equalTo(arrowImageView.snp.left).offset(-10)

        }
        
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    lazy var frontImageView: UIImageView = {
       var frontImageView = UIImageView()
        frontImageView.image = UIImage.init(named: "icon_center_point")
        return frontImageView
    }()

    lazy var titleLabel:UILabel = {
        var titleLabel = UILabel()
        titleLabel.font = SCFont(15)
        titleLabel.textColor = UIColor.blackColor()
        titleLabel.text = "统计类考研"
        return titleLabel
    }()
    
    lazy var arrowImageView: UIImageView = {
        var arrowImageView = UIImageView()
        arrowImageView.image = UIImage.init(named: "common_icon_arrow")
        return arrowImageView
    }()
    
}
