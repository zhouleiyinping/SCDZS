//
//  SCE_BookListTableViewCell.swift
//  SCDZS
//
//  Created by 周磊 on 16/7/19.
//  Copyright © 2016年 周磊. All rights reserved.
//

import UIKit

class SCE_BookListTableViewCell: UITableViewCell {

    var itemModel = SCE_BookListModel() {
        
        didSet{
            
            bgImageView.kf_setImageWithURL(NSURL(string: itemModel.bgImg!)!, placeholderImage: placeholderImage)
            bookImageView.kf_setImageWithURL(NSURL(string: itemModel.pic!)!, placeholderImage: placeholderImage)
            bookNameLabel.text = itemModel.name!
            let size = String(format: "大小：%.1fM", Float(itemModel.size!)/1024/1024)
            bookSizeLabel.text = size
            bookDownloadNumber.text = "下载：\(itemModel.downum!)"
        }
    }
    
    
    
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        self.addSubview(bgImageView)
        self.addSubview(bookImageView)
        self.addSubview(bookNameLabel)
        self.addSubview(bookSizeLabel)
        self.addSubview(bookDownloadNumber)
        bgImageView.snp.makeConstraints { (make) in
            make.top.left.equalTo(self).offset(10)
            make.bottom.equalTo(self).offset(-10)
            make.width.equalTo(90)
        }
        bookImageView.snp.makeConstraints { (make) in
            make.top.equalTo(bgImageView).offset(5)
            make.centerX.equalTo(bgImageView).offset(0)
            make.bottom.equalTo(bgImageView).offset(-5)
            make.width.equalTo(70)
        }
        
        bookSizeLabel.snp.makeConstraints { (make) in
            make.bottom.equalTo(self).offset(-10)
            make.left.equalTo(bgImageView.snp.right).offset(5)
        }
        
        bookNameLabel.snp.makeConstraints { (make) in
            make.top.equalTo(self).offset(10)
            make.left.equalTo(bgImageView.snp.right).offset(5)
            make.right.equalTo(self).offset(-10)
        }
        
        bookDownloadNumber.snp.makeConstraints { (make) in
            make.bottom.equalTo(self).offset(-10)
            make.right.equalTo(self).offset(-10)
        }
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    lazy var bookImageView:UIImageView = {
        var bookImageView = UIImageView()
        return bookImageView
    }()
    
    lazy var bgImageView:UIImageView = {
        var bgImageView = UIImageView()
        return bgImageView
    }()
    
    lazy var bookNameLabel:UILabel = {
        var bookNameLabel = UILabel()
        bookNameLabel.numberOfLines = 0
        bookNameLabel.font = SCFont(15)
        return bookNameLabel
    }()

    lazy var bookSizeLabel:UILabel = {
        var bookSizeLabel = UILabel()
        bookSizeLabel.font = SCFont(13)
        bookSizeLabel.textColor = UIColor.grayColor()

        return bookSizeLabel
    }()
    
    lazy var bookDownloadNumber:UILabel = {
        var bookDownloadNumber = UILabel()
        bookDownloadNumber.font = SCFont(13)
        bookDownloadNumber.textColor = UIColor.grayColor()

        return bookDownloadNumber
    }()
    
}
