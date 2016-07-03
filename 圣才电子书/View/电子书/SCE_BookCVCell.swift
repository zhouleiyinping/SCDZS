//
//  SCE_BookCVCell.swift
//  SCDZS
//
//  Created by 周磊 on 16/7/1.
//  Copyright © 2016年 周磊. All rights reserved.
//

import UIKit

class SCE_BookCVCell: UICollectionViewCell {
    
    
    var e_BookModelItem :SCE_BookModelItem = SCE_BookModelItem() {
        
        didSet {
            
            bookName.text = e_BookModelItem.short_name!
            bookNumber.text = "(\(e_BookModelItem.EBookNum!))"

        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.backgroundColor = UIColor.whiteColor()
        
        self.addSubview(bookName)
        bookName.snp.makeConstraints { (make) in
            make.centerY.equalTo(self.snp.centerY).offset(0)
            make.left.equalTo(self).offset(20)
        }
        
        self.addSubview(bookNumber)
        bookNumber.snp.makeConstraints { (make) in
            make.centerY.equalTo(self.snp.centerY).offset(0)
            make.left.equalTo(bookName.snp.right).offset(10)
        }
        
//        let horizontalLine = UIView()
//        horizontalLine.backgroundColor = BgColor
//        self.addSubview(horizontalLine)
//        horizontalLine.snp.makeConstraints { (make) in
//            make.left.right.equalTo(self).offset(0)
//            make.bottom.equalTo(self).offset(0)
//            make.height.equalTo(1)
//        }
//        
//        let verticalLine = UIView()
//        verticalLine.backgroundColor = BgColor
//        self.addSubview(verticalLine)
//        verticalLine.snp.makeConstraints { (make) in
//            make.top.bottom.equalTo(self).offset(0)
//            make.right.equalTo(self).offset(0)
//            make.width.equalTo(1)
//        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    lazy var bookName:UILabel = {
        var bookName = UILabel()
        bookName.font = SCFont(15)
        bookName.textColor = RGB(11, g: 11, b: 11)
        return bookName
    }()
    
    lazy var bookNumber:UILabel = {
        var bookNumber = UILabel()
        bookNumber.font = SCFont(15)
        bookNumber.textColor = RGB(145, g: 145, b: 145)
        return bookNumber
    }()
}
