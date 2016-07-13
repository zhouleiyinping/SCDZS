//
//  SCHomeHotSpotsCell.swift
//  SCDZS
//
//  Created by 周磊 on 16/7/12.
//  Copyright © 2016年 周磊. All rights reserved.
// 热点

import UIKit

class hotSpotsCCell: UICollectionViewCell {
    
    
    var homeHotSpotsModel:SCHomeHotSpotsModel = SCHomeHotSpotsModel(){
        
        didSet{
            titleLabel.text = homeHotSpotsModel.title!
        }
    }
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.addSubview(roundDotImageView)
        self.addSubview(titleLabel)
        roundDotImageView.snp.makeConstraints { (make) in
            make.centerY.equalTo(self.snp.centerY).offset(0)
            make.left.equalTo(self).offset(5)
            make.width.height.equalTo(3)
        }
        
        titleLabel.snp.makeConstraints { (make) in
            make.centerY.equalTo(self.snp.centerY).offset(0)
            make.left.equalTo(self.roundDotImageView.snp.right).offset(3)
            make.right.equalTo(self).offset(-5)
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    lazy var roundDotImageView:UIImageView = {
        var roundDotImageView = UIImageView()
        roundDotImageView.image = UIImage.init(named: "newImessage")
        return roundDotImageView
    }()
    
    lazy var titleLabel:UILabel = {
        var titleLabel = UILabel()
        titleLabel.font = SCFont(13)
        titleLabel.textColor = UIColor.blackColor()
        return titleLabel
    }()
    
}


class SCHomeHotSpotsCell: UITableViewCell,UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout {
    
    var timer:dispatch_source_t!
    
    var homeHotSpotsModelArray = [SCHomeHotSpotsModel]() {
        
        didSet{
            self.cellCollectionView.reloadData()
        }
    }

    var cellCollectionView:UICollectionView!
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        self.addSubview(bgImageView)
        self.addSubview(lineView)

        bgImageView.snp.makeConstraints { (make) in
            make.centerY.equalTo(self.snp.centerY).offset(0)
            make.left.equalTo(self).offset(10)
            make.width.height.equalTo(50)
        }
        
        lineView.snp.makeConstraints { (make) in
            make.left.equalTo(bgImageView.snp.right).offset(10)
            make.top.equalTo(bgImageView.snp.top).offset(0)
            make.bottom.equalTo(bgImageView.snp.bottom).offset(0)
            make.width.equalTo(1)
        }
        
        setCellCollectionView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setCellCollectionView() {
        
        let flowLayout =  UICollectionViewFlowLayout()
        flowLayout.scrollDirection = UICollectionViewScrollDirection.Vertical

        self.cellCollectionView = UICollectionView.init(frame: CGRectZero, collectionViewLayout: flowLayout)
        self.cellCollectionView.delegate=self
        self.cellCollectionView.dataSource=self
        self.cellCollectionView.scrollsToTop = true
        self.cellCollectionView.registerClass(hotSpotsCCell.self, forCellWithReuseIdentifier: "hotSpotsCCell")
        self.cellCollectionView.showsVerticalScrollIndicator = false
        self.cellCollectionView.scrollEnabled = false
        self.addSubview(self.cellCollectionView)
        
        self.cellCollectionView.snp.makeConstraints { (make) in
            make.top.equalTo(self.bgImageView.snp.top).offset(0)
            make.bottom.equalTo(self.bgImageView.snp.bottom).offset(0)
            make.right.equalTo(self).offset(0)
            make.left.equalTo(self.lineView.snp.right).offset(5)
        }
        
        openTimer()
    }
    
    func openTimer() {
        
        var index = 0
        
        // 获得队列
        let queue = dispatch_get_main_queue();

        // 创建一个定时器(dispatch_source_t本质还是个OC对象)
        self.timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0, queue)
        
        // 设置定时器的各种属性（几时开始任务，每隔多长时间执行一次）
        // GCD的时间参数，一般是纳秒（1秒 == 10的9次方纳秒）
        // 何时开始执行第一个任务
        // dispatch_time(DISPATCH_TIME_NOW, 1.0 * NSEC_PER_SEC) 比当前时间晚3秒
        let start = dispatch_time(DISPATCH_TIME_NOW, (Int64)(1 * NSEC_PER_SEC))

       let interval = (UInt64)(3 * NSEC_PER_SEC);

        dispatch_source_set_timer(self.timer, start, interval, 0);

        dispatch_source_set_event_handler(self.timer) {
            
            
            if index < self.homeHotSpotsModelArray.count-1 {
                
                index = index + 1
                
            }  else {
                
                index = 0

            }
            
            self.cellCollectionView.scrollToItemAtIndexPath(NSIndexPath.init(forRow: 0, inSection: index), atScrollPosition: UICollectionViewScrollPosition.Top, animated: true)
        }
        // 启动定时器
        dispatch_resume(self.timer)
    }
    
    func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        
        return self.homeHotSpotsModelArray.count
    }
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 1
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        
        let homeHotSpotsModel = self.homeHotSpotsModelArray[indexPath.section]
        
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("hotSpotsCCell", forIndexPath: indexPath) as! hotSpotsCCell
        cell.backgroundColor = UIColor.whiteColor()
        cell.homeHotSpotsModel = homeHotSpotsModel
        
        return cell
    }
    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {
        
        return CGSizeMake(ScreenWidth - 75, 25)
    }
    
    
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        
        
        let cell = collectionView.cellForItemAtIndexPath(indexPath) as! hotSpotsCCell
        
        UIView.animateWithDuration(0, animations: {
            cell.backgroundColor = UIColor.grayColor()
            }) { (finished) in
                UIView.animateWithDuration(0.5, animations: {
                    cell.backgroundColor = UIColor.whiteColor()
                })
        }
        
        let homeHotSpotsModel = self.homeHotSpotsModelArray[indexPath.section]
        self.HotSpotsSignal.sendNext(homeHotSpotsModel)
    }
    
    lazy var HotSpotsSignal:RACSubject = {
        var HotSpotsSignal = RACSubject.init()
        return HotSpotsSignal
    }()
    
    lazy var bgImageView:UIImageView = {
        var bgImageView = UIImageView()
        bgImageView.kf_setImageWithURL(NSURL(string: "http://www.100xuexi.com/app/WxFirstPage/weixin/20160505132950439.png")!, placeholderImage: placeholderImage)

        return bgImageView
    }()
    
    lazy var lineView:UIView = {
        var lineView = UIView()
        lineView.backgroundColor = BgColor
        return lineView
    }()
}
