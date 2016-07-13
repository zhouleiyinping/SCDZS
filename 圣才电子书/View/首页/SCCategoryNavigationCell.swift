//
//  SCCategoryNavigationCell.swift
//  SCDZS
//
//  Created by 周磊 on 16/7/13.
//  Copyright © 2016年 周磊. All rights reserved.
//  产品分类导航

import UIKit

class SCCategoryNavigationCell: UITableViewCell {

    
    var homeCategoryNavigationModelArray = [SCHomeCategoryNavigationModel]() {
        
        didSet{
            
            let topBottomClearance = 150 / 3
            let aboutClearance = ScreenWidth / 5
            
            for i in 0..<15 {
                
                let categoryNavigationModel = homeCategoryNavigationModelArray[i]
                
                let titleButton = UIButton()
                
                if i == 14 {
                    titleButton.setTitle("···", forState: UIControlState.Normal)

                }else {
                    titleButton.setTitle(categoryNavigationModel.name!, forState: UIControlState.Normal)

                }
                titleButton.tag = i+100
                titleButton.addTarget(self, action: #selector(SCCategoryNavigationCell.clickButton(_:)), forControlEvents: UIControlEvents.TouchUpInside)
                titleButton.setTitleColor(RGB(97, g: 110, b: 139), forState: UIControlState.Normal)
                titleButton.setTitleColor(UIColor.redColor(), forState: UIControlState.Selected)
                self.addSubview(titleButton)
                
                titleButton.snp.makeConstraints(closure: { (make) in
                    make.width.equalTo(aboutClearance)
                    make.height.equalTo(topBottomClearance)
                    make.left.equalTo(CGFloat(i%5)*aboutClearance)
                    make.top.equalTo((i/5)*topBottomClearance)
                })
            }
        }
    }

    lazy var CategoryNavigationSignal:RACSubject = {
        var CategoryNavigationSignal = RACSubject.init()
        return CategoryNavigationSignal
    }()
    
    func clickButton(button:UIButton) {
        
        let index = button.tag - 100

        let model:SCHomeCategoryNavigationModel!
        
        if index == 14 {
            
            model = SCHomeCategoryNavigationModel()
            model.name = "电子书"
        }else {
            
            model = homeCategoryNavigationModelArray[index]

        }
        
        self.CategoryNavigationSignal.sendNext(model)
    }
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
}
