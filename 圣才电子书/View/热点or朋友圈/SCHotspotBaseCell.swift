//
//  SCHotspotBaseCell.swift
//  SCDZS
//
//  Created by 周磊 on 16/7/4.
//  Copyright © 2016年 周磊. All rights reserved.
//

import UIKit

class SCHotspotBaseCell: UITableViewCell {

    lazy var titleLabel:UILabel = {
        var titleLabel = UILabel()
        titleLabel.font = SCFont(16)
        titleLabel.textColor = UIColor.blackColor()
        titleLabel.numberOfLines = 2
        titleLabel.textAlignment = NSTextAlignment.Left
        return titleLabel
    }()
    
    lazy var authorName:UILabel = {
        var authorName = UILabel ()
        authorName.textColor = UIColor.grayColor()
        authorName.font = SCFont(13)
        authorName.numberOfLines = 2
        authorName.textAlignment = NSTextAlignment.Left
        return authorName
    }()
       
    lazy var bgImageView:UIImageView = {
        var bgImageView = UIImageView ()
        return bgImageView
    }()


}
