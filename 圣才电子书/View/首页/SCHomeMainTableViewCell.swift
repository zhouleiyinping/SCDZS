//
//  SCHomeMainTableViewCell.swift
//  SCDZS
//
//  Created by 周磊 on 16/7/18.
//  Copyright © 2016年 周磊. All rights reserved.
//

import UIKit

class SCHomeMainTableViewCell: UITableViewCell,UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout {

    var sectionTitlesArray = [String]()
    
    var homeMainModelArray = [SCHomeMainModel]() {
        
        
        didSet {
            
            for homeMainModel in homeMainModelArray {
                
                sectionTitlesArray.append(homeMainModel.titleName!)
            }
             segmentedControl.sectionTitles = sectionTitlesArray
            cellCollection.reloadData()

        }
    }
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        self.addSubview(segmentedControl)
        segmentedControl.snp.makeConstraints { (make) in
            make.top.left.equalTo(self).offset(0)
            make.right.equalTo(self).offset(-40)
            make.height.equalTo(45)
        }
        
        self.addSubview(cellCollection)
        cellCollection.snp.makeConstraints { (make) in
            make.top.equalTo(segmentedControl.snp.bottom).offset(0)
            make.left.right.bottom.equalTo(self).offset(0)
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    /// 选项卡
    lazy var segmentedControl:HMSegmentedControl  = {
        
        var segmentedControl:HMSegmentedControl = HMSegmentedControl.init(sectionTitles: [])
        /**设置滚动条高度*/
        segmentedControl.selectionIndicatorHeight = 0;
        /**设置未选中的字体大小和颜色*/
        segmentedControl.titleTextAttributes = [NSForegroundColorAttributeName:RGB(103, g: 121, b: 150),NSFontAttributeName:UIFont.systemFontOfSize(13)]
        /**设置选中的字体大小和颜色*/
        segmentedControl.selectedTitleTextAttributes = [NSForegroundColorAttributeName:RGB(216, g: 95, b: 95),NSFontAttributeName:UIFont.systemFontOfSize(15)]
        /**添加点击事件*/
        segmentedControl.addTarget(self, action: #selector(SCHomeMainTableViewCell.segmentedControlChangedValue(_:)), forControlEvents: UIControlEvents.ValueChanged)
        segmentedControl.backgroundColor = RGB(249, g: 249, b: 249)
        return segmentedControl
    }()
    
    lazy var cellCollection:UICollectionView = {
       
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.sectionInset            = UIEdgeInsetsMake(0, 0, 0, 0)
        flowLayout.minimumInteritemSpacing = 0.0
        flowLayout.minimumLineSpacing      = 0.0
        flowLayout.scrollDirection = UICollectionViewScrollDirection.Horizontal
        
        var cellCollection = UICollectionView.init(frame: CGRectZero, collectionViewLayout: flowLayout)
        cellCollection.backgroundColor = UIColor.whiteColor()
        cellCollection.delegate=self
        cellCollection.dataSource=self
        cellCollection.scrollsToTop = true
        cellCollection.pagingEnabled = true
        cellCollection.showsHorizontalScrollIndicator = false
        cellCollection.registerClass(SCHomeMainCCell.self, forCellWithReuseIdentifier: "SCHomeMainCCell")
        return cellCollection
    }()
    
    
    func segmentedControlChangedValue(sender:HMSegmentedControl) {
        
        segmentedControl.selectedSegmentIndex = sender.selectedSegmentIndex
        cellCollection.contentOffset = CGPointMake(0,0)
        cellCollection.reloadData()
    }
    
  
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        let homeMainModel = homeMainModelArray[segmentedControl.selectedSegmentIndex]
        return homeMainModel.homeBooksModelArray.count
        
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        
        let homeMainModel = homeMainModelArray[segmentedControl.selectedSegmentIndex]
        let homeBooksModel = homeMainModel.homeBooksModelArray[indexPath.row]
        
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("SCHomeMainCCell", forIndexPath: indexPath) as! SCHomeMainCCell
        
        cell.homeBooksModel = homeBooksModel
        
        return cell
    }
    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize  {
        return CGSizeMake(ScreenWidth/2, (450-45)/2)
    }
    
}
