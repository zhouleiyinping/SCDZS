//
//  SCHomeDiscoverCell.swift
//  SCDZS
//
//  Created by 周磊 on 16/7/9.
//  Copyright © 2016年 周磊. All rights reserved.
//  热点

import UIKit

class discoverMainView: UIView {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.addSubview(bgImageView)
        self.addSubview(titlelabel)
        bgImageView.snp.makeConstraints { (make) in
            make.centerX.equalTo(self.snp.centerX).offset(0)
            make.top.equalTo(self).offset(10)
            make.width.height.equalTo(35)
        }
        titlelabel.snp.makeConstraints { (make) in
            make.centerX.equalTo(self.snp.centerX).offset(0)
            make.top.equalTo(bgImageView.snp.bottom).offset(10)
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    lazy var bgImageView:UIImageView = {
        var bgImageView = UIImageView()
        return bgImageView
    }()
    
    lazy var titlelabel:UILabel = {
        var titlelabel = UILabel()
        titlelabel.font = SCFont(15)
        titlelabel.textColor =  UIColor.blackColor()
        titlelabel.text = "热点"
        titlelabel.textAlignment = NSTextAlignment.Center
        return titlelabel
    }()
    
}


class SCHomeDiscoverCell: UITableViewCell {

    var mainView:discoverMainView!
    
    var homeDiscoverModelArray = [SCHomeDiscoverModel]() {
        
        didSet{
            
            for i in 0..<homeDiscoverModelArray.count {
                mainView = discoverMainView()
                /////设置允许交互属性
                mainView.userInteractionEnabled = true
                
                /////添加tapGuestureRecognizer手势
                let tapGR = UITapGestureRecognizer(target: self, action: #selector(SCHomeDiscoverCell.tapHandler(_:)))
                mainView.addGestureRecognizer(tapGR)
                
                mainView.tag = i+100
                
                self.addSubview(mainView)
                mainView.snp.makeConstraints(closure: { (make) in
                    make.top.bottom.equalTo(self).offset(0)
                    make.width.equalTo(ScreenWidth/4)
                    make.left.equalTo(self).offset(CGFloat(i)*(ScreenWidth/4))
                })
                
                let homeDiscoverModel = homeDiscoverModelArray[i]
                mainView.titlelabel.text = homeDiscoverModel.tab_name!
                mainView.bgImageView.kf_setImageWithURL(NSURL(string: (homeDiscoverModel.tab_icon!))!, placeholderImage: placeholderImage)
            }
        }
    }

    func tapHandler(recognizer:UITapGestureRecognizer) {
        
        let clickView:discoverMainView = recognizer.view as! discoverMainView

        let discoverModel = homeDiscoverModelArray[clickView.tag - 100] 
        
        self.DiscoverSignal.sendNext(discoverModel)
        
    }
    
    lazy var DiscoverSignal:RACSubject = {
        var DiscoverSignal = RACSubject.init()
        return DiscoverSignal
    }()
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
      
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
        
    }
    
    
}

