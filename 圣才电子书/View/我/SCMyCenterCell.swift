//
//  SCMyCenterCell.swift
//  SCDZS
//
//  Created by 周磊 on 16/6/27.
//  Copyright © 2016年 周磊. All rights reserved.
//

import UIKit
import Kingfisher

class SCMyCenterCell: UITableViewCell {

    /// 图片
    var titleImage:UIImageView!
    /// 标题
    var titleLabel:UILabel!
    /// 副标题
    var subhead:UILabel!
    /// 箭头
    var arrows:UIImageView!
    
    var basicDataSouce:SCMyCenterModelTabs = SCMyCenterModelTabs() {
        
        didSet {

            titleImage.kf_setImageWithURL(NSURL(string: basicDataSouce.tab_icon!)!, placeholderImage: UIImage(named: "mrt"))
            
            titleLabel.text = basicDataSouce.tab_name
            subhead.text = basicDataSouce.tab_desc
            
        }
    }
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        titleImage = UIImageView.init()
        self.addSubview(titleImage)
        titleImage.snp.makeConstraints { (make) in
            make.centerY.equalTo(self.snp.centerY).offset(0)
            make.left.equalTo(self).offset(10)
            make.height.width.equalTo(25)
            
        }
        
        titleLabel = UILabel.init()
        titleLabel.font = SCFont(16)
        titleLabel.textColor = UIColor.blackColor()
        self.addSubview(titleLabel)
        titleLabel.snp.makeConstraints { (make) in
            make.centerY.equalTo(self.snp.centerY).offset(0)
            make.left.equalTo(titleImage.snp.right).offset(10)

        }
        
        arrows = UIImageView.init()
        arrows.image = UIImage.init(named: "公用_灰色右箭头")
        self.addSubview(arrows)
        arrows.snp.makeConstraints { (make) in
            make.centerY.equalTo(self.snp.centerY).offset(0)
            make.right.equalTo(self).offset(-10)
            make.width.equalTo(8)
            make.height.equalTo(10)

        }
        
        subhead = UILabel.init()
        subhead.font = SCFont(13)
        subhead.textColor = UIColor.grayColor()
        self.addSubview(subhead)
        subhead.snp.makeConstraints { (make) in
            make.centerY.equalTo(self.snp.centerY).offset(0)
            make.right.equalTo(arrows.snp.left).offset(-5)
            
        }
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    
}
