//
//  SCFriendViewController.swift
//  圣才电子书
//
//  Created by 周磊 on 16/6/17.
//  Copyright © 2016年 周磊. All rights reserved.
//

import UIKit

class SCFriendViewController: SCBaseViewController,UIScrollViewDelegate {
    
    var hotspotModelArray = [allCategory]()
    var hotspotCategoryArray = [String]()

    
    
    lazy var mainScrollView:UIScrollView = {
        
       var  mainScrollView = UIScrollView();
        mainScrollView.contentSize = CGSizeMake((ScreenWidth * CGFloat(Float(self.hotspotModelArray.count))), ScreenHeight-64-45-50);
        mainScrollView.pagingEnabled = true
        mainScrollView.bounces = false
        mainScrollView.showsHorizontalScrollIndicator = false
        mainScrollView.showsVerticalScrollIndicator = false
        mainScrollView.directionalLockEnabled = true
        mainScrollView.delegate = self
        mainScrollView.contentOffset = CGPointMake(0, 0)
        mainScrollView.backgroundColor = UIColor.whiteColor()
        return mainScrollView
    }()
    
    lazy var segmentedControl:HMSegmentedControl = {
        
       var segmentedControl = HMSegmentedControl(sectionTitles: self.hotspotCategoryArray)
        segmentedControl.autoresizingMask = UIViewAutoresizing.FlexibleRightMargin
        segmentedControl.autoresizingMask = UIViewAutoresizing.FlexibleWidth
        //设置滚动条的位置为下
        segmentedControl.selectionIndicatorLocation = HMSegmentedControlSelectionIndicatorLocationDown
        //设置滚动条高度
        segmentedControl.selectionIndicatorHeight = 2;
        //设置未选中的字体大小和颜色
        segmentedControl.titleTextAttributes = [NSForegroundColorAttributeName:UIColor.blackColor(),NSFontAttributeName:UIFont.systemFontOfSize(15)]
        /**设置选中的字体大小和颜色*/
        segmentedControl.selectedTitleTextAttributes = [NSForegroundColorAttributeName:UIColor.redColor(),NSFontAttributeName:UIFont.systemFontOfSize(17)]
        /**设置滚动条颜色*/
        segmentedControl.selectionIndicatorColor = UIColor.redColor()
        /**添加点击事件*/
        segmentedControl.addTarget(self, action: #selector(SCFriendViewController.segmentedControlChangedValue(_:)), forControlEvents: UIControlEvents.ValueChanged)

        return segmentedControl
    }()
    
    func segmentedControlChangedValue(sender:HMSegmentedControl) {
        
        let segment:HMSegmentedControl = sender
        mainScrollView.contentOffset = CGPointMake(CGFloat(Float(segment.selectedSegmentIndex))*ScreenWidth, 0);
        addControllersWhenSlider(segmentedControl.selectedSegmentIndex)

    }
    
    // MARK: - SCHotspotVM
    lazy var hotspotVM:SCHotspotVM = {
        let hotspotVM = SCHotspotVM()
        return hotspotVM
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.view.backgroundColor = BgColor
        self.backBtn.hidden = true
        self.homeBtn.hidden = true
        self.searchBtn.hidden = true
        self.titleLabel.text = "热点"
        requestDataSouce()
        
    }

    func setSubviews() {
        
        self.view.addSubview(segmentedControl)
        segmentedControl.snp.makeConstraints { (make) in
            make.left.right.equalTo(self.view).offset(0)
            make.top.equalTo(self.view).offset(NavigationH)
            make.height.equalTo(40)
        }
        self.view.addSubview(mainScrollView)
        mainScrollView.snp.makeConstraints { (make) in
            make.left.right.equalTo(self.view).offset(0)
            make.top.equalTo(segmentedControl.snp.bottom).offset(0)
            make.bottom.equalTo(self.view).offset(-50)
        }
        
        let lineView = UIView()
        lineView.backgroundColor = UIColor.blackColor()
        self.view.addSubview(lineView)
        lineView.bringSubviewToFront(segmentedControl)
        lineView.snp.makeConstraints { (make) in
            make.left.right.equalTo(self.view).offset(0)
            make.top.equalTo(self.view).offset(104.5)
            make.height.equalTo(0.5)
        }

        addViewControllers()
    }
    
    
    // MARK: - 请求数据
    func requestDataSouce() {
        
        weak var wself = self
        // 发送请求
        let signal = self.hotspotVM.requestCommand.execute(nil)
        signal.subscribeNext({ (dataArray) in
            
            wself!.hotspotModelArray = (dataArray as? [allCategory])!
            
            for i in 0..<wself!.hotspotModelArray.count {
                let allCategory = wself!.hotspotModelArray[i]
                wself!.hotspotCategoryArray.append(allCategory.Name!)
            }
            }, error: { (error) in
                wself?.showErrorHUDWithMessage("哎呀，出错了")
        }) {
            wself!.setSubviews()
        }
        
    }
    
    
    func addViewControllers() {
        
        for i in 0 ..< hotspotModelArray.count {
            
            let allCategory = self.hotspotModelArray[i]
            let rankingView = SCHotspotTableViewController()
            rankingView.categroyId = String(allCategory.Id!)
            self.addChildViewController(rankingView)
        }
        /// 添加默认控制器
        let rankingVC:SCHotspotTableViewController = (self.childViewControllers[0] as! SCHotspotTableViewController)
        rankingVC.view.frame = mainScrollView.bounds;
        mainScrollView.addSubview(rankingVC.view)
    }

    
    
    
    func scrollViewDidEndDecelerating(scrollView: UIScrollView) {
        
        scrollViewDidEndScrollingAnimation(scrollView)
        
    }
    
    func scrollViewDidEndScrollingAnimation(scrollView: UIScrollView) {
        
        let index = scrollView.contentOffset.x / CGRectGetWidth(self.view.bounds)
        
        segmentedControl.selectedSegmentIndex =  Int(Float(index))
        addControllersWhenSlider(segmentedControl.selectedSegmentIndex)

        
    }

    func addControllersWhenSlider(index:Int) {
        
        let rankingView:SCHotspotTableViewController = (self.childViewControllers[index] as! SCHotspotTableViewController)
        rankingView.view.frame = mainScrollView.bounds
        mainScrollView.addSubview(rankingView.view)
        
    }

    
    
    
}
