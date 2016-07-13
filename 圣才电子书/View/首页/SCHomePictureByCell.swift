//
//  SCHomePictureByCell.swift
//  SCDZS
//
//  Created by 周磊 on 16/7/8.
//  Copyright © 2016年 周磊. All rights reserved.
//

import UIKit

class SCHomePictureByCell: UITableViewCell {

    
    var homeCarouselModelArray = [SCHomeCarouselModel]() {
        
        didSet{
            
            let homeCarouselModel = homeCarouselModelArray.last
            bgImageView.kf_setImageWithURL(NSURL(string: (homeCarouselModel?.pic_url!)!)!, placeholderImage: placeholderImage)
            
        }
    }
    
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        self.addSubview(bgImageView)
        bgImageView.snp.makeConstraints { (make) in
            make.edges.equalTo(self).offset(0)
        }
        
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    lazy  var bgImageView: UIImageView = {
       var bgImageView =  UIImageView()
        return bgImageView
    }()
    
}
