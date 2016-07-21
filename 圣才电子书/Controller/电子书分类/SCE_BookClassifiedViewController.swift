
//
//  SCE_BookClassifiedViewController.swift
//  SCDZS
//
//  Created by 周磊 on 16/7/19.
//  Copyright © 2016年 周磊. All rights reserved.

import UIKit

class SCE_BookClassifiedViewController: SCBaseViewController {


    var e_BookClassifiedArray:[SCE_BookClassifiedModel]!

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = BgColor
        
        self.view.addSubview(tableView)
        tableView.snp.makeConstraints { (make) in
            make.top.equalTo(self.view).offset(NavigationH)
            make.left.bottom.right.equalTo(self.view).offset(0)
        }
    }
    
    lazy var tableView:UITableView = {
        var tableView = UITableView()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.tableFooterView = UIView()
        tableView.registerClass(SCE_BookClassifiedCell.self, forCellReuseIdentifier: "SCE_BookClassifiedCell")
        return tableView
    }()
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        self.tableView.separatorInset = UIEdgeInsetsMake(0,0,0,0)
        self.tableView.layoutMargins = UIEdgeInsetsMake(0,0,0,0)
        
    }
    
}
extension SCE_BookClassifiedViewController:UITableViewDelegate,UITableViewDataSource {
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        
        return e_BookClassifiedArray.count
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        let e_BookClassifiedModel = e_BookClassifiedArray[section]
        
        return e_BookClassifiedModel.itemArray.count
    }
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let e_BookClassifiedModel = e_BookClassifiedArray[indexPath.section]
        let itemModel = e_BookClassifiedModel.itemArray[indexPath.row]
        
        let cell = tableView.dequeueReusableCellWithIdentifier("SCE_BookClassifiedCell", forIndexPath: indexPath) as! SCE_BookClassifiedCell
        
        cell.titleLabel.text = itemModel.name!
        
        return cell
    }
    

    func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 40
    }
    
    func tableView(tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let e_BookClassifiedModel = e_BookClassifiedArray[section]
        let headerView = SCE_BookClassifiedHeaderView()
        headerView.titleLabel.text = e_BookClassifiedModel.name!
        return headerView
    }
    
    func tableView(tableView: UITableView, willDisplayCell cell: UITableViewCell, forRowAtIndexPath indexPath: NSIndexPath) {
        
            cell.separatorInset = UIEdgeInsetsZero
            cell.layoutMargins = UIEdgeInsetsZero
    }
}