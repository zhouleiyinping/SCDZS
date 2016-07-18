//
//  SCHomeMainCCell.swift
//  SCDZS
//
//  Created by 周磊 on 16/7/18.
//  Copyright © 2016年 周磊. All rights reserved.
//

import UIKit

class SCHomeMainCCell: UICollectionViewCell {
    
    var homeBooksModel = SCHomeBooksModel() {
        
        didSet {
            

            bgImageView.kf_setImageWithURL(NSURL(string: homeBooksModel.bgImg!)!, placeholderImage: placeholderImage)
            bookImageView.kf_setImageWithURL(NSURL(string: homeBooksModel.pic!)!, placeholderImage: placeholderImage)
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        let bgView = UIView()
        bgView.backgroundColor = UIColor.whiteColor()
        self.addSubview(bgView)
        bgView.snp.makeConstraints { (make) in
            make.edges.equalTo(self).offset(0)
        }
        
        bgView.addSubview(bgImageView)
        bgView.addSubview(bookImageView)
        bgImageView.snp.makeConstraints { (make) in
            make.top.left.equalTo(bgView).offset(10)
            make.bottom.right.equalTo(bgView).offset(-10)

        }
        bookImageView.snp.makeConstraints { (make) in
            make.centerX.equalTo(self.snp.centerX).offset(0)
            make.top.equalTo(bgImageView.snp.top).offset(10)
            make.bottom.equalTo(bgImageView.snp.bottom).offset(-10)
            make.width.equalTo(120)
        }
        
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    lazy var bgImageView:UIImageView = {
        var bgImageView = UIImageView()
        return bgImageView
    }()
    
    lazy var bookImageView:UIImageView = {
        var bookImageView = UIImageView()
       
        return bookImageView
    }()
    
}
