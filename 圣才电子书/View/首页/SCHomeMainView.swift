//
//  SCHomeMainView.swift
//  SCDZS
//
//  Created by 周磊 on 16/7/7.
//  Copyright © 2016年 周磊. All rights reserved.
//

import UIKit

class SCHomeMainView: UIView {

    var homeModelArray = [SCHomeModel]() {
        
        didSet{
            self.addSubview(homeTableView)
            homeTableView.snp.makeConstraints { (make) in
                make.left.right.bottom.equalTo(self).offset(0)
                make.top.equalTo(self).offset(20)
            }
           homeTableView.reloadData()
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = UIColor.whiteColor()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    lazy var homeTableView:UITableView = {
       var homeTableView = UITableView()
        homeTableView.delegate = self
        homeTableView.dataSource = self
        homeTableView.registerClass(UITableViewCell.self, forCellReuseIdentifier: "cell")
        homeTableView.registerClass(SCHomePictureByCell.self, forCellReuseIdentifier: "SCHomePictureByCell")
        homeTableView.registerClass(SCHomeDiscoverCell.self, forCellReuseIdentifier: "SCHomeDiscoverCell")
        homeTableView.registerClass(SCCategoryNavigationCell.self, forCellReuseIdentifier: "SCCategoryNavigationCell")
        homeTableView.registerClass(SCHomeHotSpotsCell.self, forCellReuseIdentifier: "SCHomeHotSpotsCell")

        homeTableView.separatorStyle = UITableViewCellSeparatorStyle.None
        return homeTableView
    }()
    
    
    lazy var MainHotSpotsSignal:RACSubject = {
        var MainHotSpotsSignal = RACSubject.init()
        return MainHotSpotsSignal
    }()
    
    lazy var MainDiscoverSignal:RACSubject = {
        var MainDiscoverSignal = RACSubject.init()
        return MainDiscoverSignal
    }()
    
    lazy var MainCategoryNavigationSignal:RACSubject = {
        var MainCategoryNavigationSignal = RACSubject.init()
        return MainCategoryNavigationSignal
    }()
    
    
}
extension SCHomeMainView:UITableViewDelegate,UITableViewDataSource {
    
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return homeModelArray.count
    }
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let homeModel = self.homeModelArray[indexPath.row ]
        
        
        switch homeModel.cellType {
        case .PictureBy,.OldPictureBy:
            
        let cell = tableView.dequeueReusableCellWithIdentifier("SCHomePictureByCell", forIndexPath: indexPath) as! SCHomePictureByCell
            
            cell.homeCarouselModelArray = homeModel.homeCarouselModelArray
        
            return cell
            
        case .spaceCell:
            
            let cell = tableView .dequeueReusableCellWithIdentifier("cell", forIndexPath: indexPath)
            cell.backgroundColor = BgColor
            return cell
            
        case .Discover:
            
            let cell = tableView.dequeueReusableCellWithIdentifier("SCHomeDiscoverCell", forIndexPath: indexPath) as! SCHomeDiscoverCell
            
            cell.homeDiscoverModelArray = homeModel.homeDiscoverModelArray
            cell.selectionStyle = UITableViewCellSelectionStyle.None
            
            cell.DiscoverSignal.subscribeNext({ (value) in
                
                self.MainDiscoverSignal.sendNext(value)
            })
            
            return cell
        case .HotSpots:
            
            let cell = tableView.dequeueReusableCellWithIdentifier("SCHomeHotSpotsCell", forIndexPath: indexPath) as! SCHomeHotSpotsCell
            cell.homeHotSpotsModelArray = homeModel.homeHotSpotsModelArray
            cell.HotSpotsSignal.subscribeNext({ (value) in
            self.MainHotSpotsSignal.sendNext(value)
            })
            return cell
        case .CategoryNavigation:
            
            let cell = tableView.dequeueReusableCellWithIdentifier("SCCategoryNavigationCell", forIndexPath: indexPath) as! SCCategoryNavigationCell
            cell.homeCategoryNavigationModelArray = homeModel.homeCategoryNavigationModelArray
            
            cell.CategoryNavigationSignal.subscribeNext({ (value) in
                self.MainCategoryNavigationSignal.sendNext(value)
            })
            return cell
        default:
            let cell = tableView .dequeueReusableCellWithIdentifier("cell", forIndexPath: indexPath)
            cell.textLabel?.text  = "\(indexPath.row)"
            return cell
        }
    }
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        let homeModel = self.homeModelArray[indexPath.row]
        
        /**
         *  indexPath.row == 1为搜索栏间隙，这里不需要，置为零
         */
        if indexPath.row == 1 || indexPath.row == 5 {
            return 0
        }
        switch homeModel.cellType {
        case .PictureBy:
            return 60
        case .spaceCell:
            return 10
        case .SearchNavigation,.OldPictureBy:
            return 0
        case .Discover:
            return 80
        case .HotSpots:
            return 60
        case .CategoryNavigation:
            return 150
        default:
            return 200
        }
    }
    func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 40
    }
    func tableView(tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let homeModel = homeModelArray[0]
        let headerView = SCHomeHeaderView()
        headerView.homeNavigationModelArray = homeModel.homeNavigationModelArray
        headerView.backgroundColor = UIColor.whiteColor()
        return headerView
    }
}