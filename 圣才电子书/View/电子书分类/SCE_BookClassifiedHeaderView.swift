//
//  SCE_BookClassifiedhewderView.swift
//  SCDZS
//
//  Created by 周磊 on 16/7/19.
//  Copyright © 2016年 周磊. All rights reserved.
//

import UIKit

class SCE_BookClassifiedHeaderView: UIView {

    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = BgColor
        self.addSubview(titleLabel)
        titleLabel.snp.makeConstraints { (make) in
            make.centerY.equalTo(self.snp.centerY).offset(0)
            make.left.equalTo(self).offset(10)
        }
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    lazy var titleLabel:UILabel = {
        var titleLabel = UILabel()
        titleLabel.font = SCFont(16)
        titleLabel.textColor = UIColor.blackColor()
        return titleLabel
    }()
}
