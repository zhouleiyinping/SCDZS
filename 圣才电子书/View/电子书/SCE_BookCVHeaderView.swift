//
//  SCE_BookCVHeaderView.swift
//  SCDZS
//
//  Created by 周磊 on 16/7/1.
//  Copyright © 2016年 周磊. All rights reserved.
//

import UIKit

class SCE_BookCVHeaderView: UICollectionReusableView {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
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
        titleLabel.font = SCFont(17)
        titleLabel.textColor = UIColor.blackColor()
        titleLabel.textAlignment  = NSTextAlignment.Center
        return titleLabel
    }()
    
}
