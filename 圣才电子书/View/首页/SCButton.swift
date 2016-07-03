//
//  SCButton.swift
//  圣才电子书
//
//  Created by 周磊 on 16/6/18.
//  Copyright © 2016年 周磊. All rights reserved.
//  自定义button

import UIKit

class SCButton: UIButton {

    override func layoutSubviews() {
        super.layoutSubviews()
        
        var center = self.imageView?.center
        center?.x = self.frame.size.width / 2
        center?.y = (self.imageView?.frame.size.height)! / 2
        self.imageView?.center = center!
        
        
        var newFrame = self.titleLabel?.frame
        newFrame?.origin.x = 0
        newFrame?.origin.y = (self.imageView?.frame.size.height)! + 3
        newFrame?.size.width = self.frame.size.width
        self.titleLabel?.frame = newFrame!
        self.titleLabel?.font = SCFont(10)
        self.titleLabel?.textAlignment = NSTextAlignment.Center
        
    }
    
    override func setTitle(title: String?, forState state: UIControlState) {
        
        super.setTitle(title, forState: state)
        
        self.titleLabel?.sizeToFit()
        
    }
    
    
    override func setImage(image: UIImage?, forState state: UIControlState) {
        
        super.setImage(image, forState: state)
        self.imageView?.sizeToFit()
    }

}
