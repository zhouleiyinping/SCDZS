//
//  SCMyCenterViewController.swift
//  圣才电子书
//
//  Created by 周磊 on 16/6/17.
//  Copyright © 2016年 周磊. All rights reserved.
//

import UIKit

class SCMyCenterViewController: SCBaseViewController {

    /// 数据源
    var dataArray  = [SCMyCenterModel]()
   
    // MARK: - viewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = BgColor
        self.backBtn.hidden = true
        self.homeBtn.hidden = true
        self.searchBtn.hidden = true
        self.titleLabel.text = "我"
        
        self.view.addSubview(self.tableView)
        self.tableView.snp.makeConstraints { (make) in
            make.top.equalTo(self.view).offset(NavigationH)
            make.left.right.equalTo(self.view).offset(0);
            make.bottom.equalTo(self.view).offset(-(self.tabBarController?.tabBar.frame.size.height)!)
        }
        /**
         显示菊花
         */
        self.showHUD()
        /**
         网络请求
         */
        requestDataSouce()
    }
    
    // MARK: - 请求数据
    func requestDataSouce() {
        
        weak var wself = self

         // 发送请求
        let signal = self.myCenterRequest.requestCommand.execute(nil)
        
        signal.subscribeNext({ (dataArray) in
            
            wself!.dataArray = (dataArray as? [SCMyCenterModel])!
                        
            }, error: { (error) in
                
                wself?.showErrorHUDWithMessage("哎呀，出错了")
                
            }) {
              wself?.hideHUD()
                wself?.tableView.reloadData()
        }
    }
    
    
    // MARK: - SCMyCenterVM
    lazy var myCenterRequest:SCMyCenterVM = {
        let myCenterRequest = SCMyCenterVM()
        return myCenterRequest
    }()
    
    
    
    // MARK: - UITableView
    lazy var tableView:UITableView = {
        let tableView = UITableView()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.backgroundColor = UIColor.clearColor()
        tableView.tableFooterView = UIView.init()
        tableView.registerClass(SCMyCenterCell.self, forCellReuseIdentifier:"SCMyCenterCell")
        return tableView
    }()
    

}

extension SCMyCenterViewController:UITableViewDelegate,UITableViewDataSource {
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        
        return self.dataArray.count
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        let myCenterModel = self.dataArray[section]
        
        return myCenterModel.tabsArray.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let myCenterModel = self.dataArray[indexPath.section]
        let myCenterModelTabs = myCenterModel.tabsArray[indexPath.row]
        
        let  cell = tableView.dequeueReusableCellWithIdentifier("SCMyCenterCell", forIndexPath: indexPath) as! SCMyCenterCell
        
        cell.selectionStyle = UITableViewCellSelectionStyle.None
        cell.basicDataSouce = myCenterModelTabs
        
        return cell
    }
    
    func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 20
    }
    
    func tableView(tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = UIView()
        headerView.backgroundColor = BgColor
        return headerView
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        tableView.deselectRowAtIndexPath(indexPath, animated: false)
        
    }

}