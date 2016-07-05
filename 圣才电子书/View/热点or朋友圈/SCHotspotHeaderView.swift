
//
//  SCHotspotHeaderView.swift
//  SCDZS
//
//  Created by 周磊 on 16/7/4.
//  Copyright © 2016年 周磊. All rights reserved.
//

import UIKit

class SCHotspotHeaderView: UIView {

    var delegateSignal:RACSubject!
    
    var topArticleModelArray :[topArticleModel] = [topArticleModel]() {
        
        didSet {
            
            for i in 0..<topArticleModelArray.count {
                
                
                let bgView = topArticleBackgroundView()
//                bgView.backgroundColor = RGB(CGFloat(arc4random()%100), g: CGFloat(arc4random()%100), b: CGFloat(arc4random()%100))
                bgView.tag = i+100
                self.addSubview(bgView)
                bgView.snp.makeConstraints(closure: { (make) in
                    make.left.right.equalTo(self).offset(0)
                    make.height.equalTo(35)
                    make.top.equalTo(self).offset(i*35)
                })
                
                let topArticle = topArticleModelArray[i]
                bgView.iconImageView.kf_setImageWithURL(NSURL(string: topArticle.imgUrl!)!, placeholderImage: placeholderImage)
                bgView.titleNameLabel.text = topArticle.title!

                let tapGestureRecognize = UITapGestureRecognizer(target: self, action: #selector(SCHotspotHeaderView.singleTapGestureRecognizer(_:)))
                tapGestureRecognize.numberOfTapsRequired = 1;
                bgView.addGestureRecognizer(tapGestureRecognize)
                
            }
        }
    }

    func singleTapGestureRecognizer(recognizer:UITapGestureRecognizer) {
        
         let backgroundView = recognizer.view as! topArticleBackgroundView
        
        backgroundView.backgroundColor = UIColor.grayColor()
        backgroundView.alpha = 0.5
        let workingQueue = dispatch_queue_create("my_queue", nil)
        dispatch_async(workingQueue) {
           
            NSThread.sleepForTimeInterval(0.5)
            dispatch_async(dispatch_get_main_queue()) {
                backgroundView.backgroundColor = UIColor.whiteColor()
                backgroundView.alpha = 1
            }
        }
        let topArticle = self.topArticleModelArray[backgroundView.tag-100]
        self.delegateSignal.sendNext(topArticle)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        let lineView = UIView()
        lineView.backgroundColor = UIColor.grayColor()
        self.addSubview(lineView)
        lineView.snp.makeConstraints { (make) in
            make.left.right.equalTo(self).offset(0)
            make.bottom.equalTo(self).offset(-1)
            make.height.equalTo(1)
        }
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

class topArticleBackgroundView : UIView {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.addSubview(self.iconImageView)
        self.addSubview(self.titleNameLabel)
        self.iconImageView.snp.makeConstraints { (make) in
            make.centerY.equalTo(self.snp.centerY).offset(0)
            make.left.equalTo(self).offset(20)
            make.width.height.equalTo(15)
        }
        self.titleNameLabel.snp.makeConstraints { (make) in
            make.centerY.equalTo(self.snp.centerY).offset(0)
            make.left.equalTo(iconImageView.snp.right).offset(10)
            make.right.equalTo(self).offset(-10)
        }
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

    
}





