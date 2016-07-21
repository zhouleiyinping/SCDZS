//
//  SCE_BookCV.swift
//  SCDZS
//
//  Created by 周磊 on 16/7/1.
//  Copyright © 2016年 周磊. All rights reserved.
// 电子书CollectionView

import UIKit

class SCE_BookCV: UIView {
    
    /// 上一个cell
    var firstIndex:NSIndexPath?
    /// 当前的cell
    var currentIndex:NSIndexPath?

    
    //数据源
    var e_BookModelArray:[SCE_BookModel] = [] {
        didSet {
            collectionView.reloadData()
        }
    }
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.addSubview(collectionView)
        collectionView.snp.updateConstraints { (make) in
            make.left.top.right.bottom.equalTo(self).offset(0)
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    lazy var CVSignal:RACSubject = {
       var CVSignal = RACSubject.init()
        return CVSignal
    }()
    
    lazy var totalNumMode:SCE_BookTotalNumMode = {
        var totalNumMode = SCE_BookTotalNumMode()
        return totalNumMode
    }()
    
    
    lazy var DidSelectItemSignal:RACSubject = {
        var DidSelectItemSignal = RACSubject.init()
        return DidSelectItemSignal
    }()
    
    

    // MARK: - collectionView
    lazy var collectionView:UICollectionView = {
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.minimumLineSpacing = 1
        flowLayout.minimumInteritemSpacing = 1

        
        var collectionView = UICollectionView.init(frame: CGRectZero, collectionViewLayout: flowLayout)
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.backgroundColor = BgColor
        collectionView.registerClass(SCE_BookCVCell.self, forCellWithReuseIdentifier: "SCE_BookCVCell")
        collectionView.registerClass(SCE_BookCVHeaderView.self, forSupplementaryViewOfKind: UICollectionElementKindSectionHeader, withReuseIdentifier: "SCE_BookCVHeaderView")
        collectionView.registerClass(SCE_BookCVTopHV.self, forSupplementaryViewOfKind: UICollectionElementKindSectionHeader, withReuseIdentifier: "SCE_BookCVTopHV")

        return collectionView
    }()
}

extension SCE_BookCV:UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout  {
    
    
    func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        return e_BookModelArray.count
    }
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        let e_BookModel = e_BookModelArray[section]
        return e_BookModel.itemsArray.count
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let e_BookModel = e_BookModelArray[indexPath.section]
        let e_BookModelItem = e_BookModel.itemsArray[indexPath.row]
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("SCE_BookCVCell", forIndexPath: indexPath) as! SCE_BookCVCell
        cell.e_BookModelItem = e_BookModelItem
        
        if indexPath == currentIndex {
            
            cell.bookName.textColor = UIColor.redColor()
            cell.bookNumber.textColor = UIColor.redColor()
        }else {
            cell.bookName.textColor = RGB(11, g: 11, b: 11)
            cell.bookNumber.textColor = RGB(145, g: 145, b: 145)
        }
        
        return cell
    }
    
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        
        let e_BookModel = e_BookModelArray[indexPath.section]
        let e_BookModelItem = e_BookModel.itemsArray[indexPath.row]
        
        currentIndex = indexPath
        
        self.collectionView.reloadData()
        
        self.DidSelectItemSignal.sendNext(e_BookModelItem)
        
    }
    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {
        
        return CGSizeMake((ScreenWidth - 1)/2, 40)
    }
    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        
        if section == 0 {
            return CGSizeMake(ScreenWidth, 140)
        }
        
        return CGSizeMake(ScreenWidth, 40)
    }
    
    func collectionView(collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, atIndexPath indexPath: NSIndexPath) -> UICollectionReusableView {
        
        let e_BookModel = e_BookModelArray[indexPath.section]
        if indexPath.section == 0 {
            
             let headerView = collectionView.dequeueReusableSupplementaryViewOfKind(kind, withReuseIdentifier: "SCE_BookCVTopHV", forIndexPath: indexPath) as! SCE_BookCVTopHV
            
            headerView.totalNumMode = totalNumMode
            
            self.CVSignal.sendNext(headerView.e_BookButton.rac_signalForControlEvents(UIControlEvents.TouchUpInside))
            
            if kind == UICollectionElementKindSectionHeader {
                
                headerView.titleLabel.text = e_BookModel.name
            }
            return headerView
            
        }else {
            
            let headerView = collectionView.dequeueReusableSupplementaryViewOfKind(kind, withReuseIdentifier: "SCE_BookCVHeaderView", forIndexPath: indexPath) as! SCE_BookCVHeaderView
            headerView.backgroundColor = BgColor
            if kind == UICollectionElementKindSectionHeader {
                
                headerView.titleLabel.text = e_BookModel.name
            }
            return headerView
        }
        
    }
}