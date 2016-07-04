
//
//  SCHotspotHeaderView.swift
//  SCDZS
//
//  Created by 周磊 on 16/7/4.
//  Copyright © 2016年 周磊. All rights reserved.
//

import UIKit

class SCHotspotHeaderView: UIView {

    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    lazy var iconImageView:UIImageView = {
         var iconImageView = UIImageView()
        return iconImageView
    }()
    
    lazy var titleNameLabel:UILabel = {
        var titleNameLabel = UILabel()
        titleNameLabel.font = SCFont(15)
        titleNameLabel.textColor = UIColor.blackColor()
        titleNameLabel.textAlignment = NSTextAlignment.Left
        return titleNameLabel
    }()
    
    lazy var bgView:UIView = {
        var bgView = UIView()
        return bgView
    }()
}
