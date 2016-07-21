//
//  SCE_BookListViewController.swift
//  SCDZS
//
//  Created by 周磊 on 16/7/19.
//  Copyright © 2016年 周磊. All rights reserved.
//

import UIKit

class SCE_BookListViewController: SCBaseViewController {

    var bookId:String!
    var e_BookListArray = [SCE_BookListModel]()

    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.view.backgroundColor = BgColor
        
        self.view.addSubview(tableView)
        tableView.snp.makeConstraints { (make) in
            make.top.equalTo(self.view).offset(NavigationH)
            make.left.bottom.right.equalTo(self.view).offset(0)
        }
        
        self.showHUD()
        let e_BookClassifiedRequest = SCE_BookClassifiedVM.init(booksId: bookId)
        // 发送请求
        let signal = e_BookClassifiedRequest.listRequestCommand.execute(nil)
        signal.subscribeNext({ (value) in
            self.e_BookListArray = value as! [SCE_BookListModel]
            
            }, error: { (error) in
                self.showErrorHUDWithMessage("哎呀，出错了")
            }, completed: {
                self.hideHUD()
                self.tableView.reloadData()
        })
    }
    
    lazy var tableView:UITableView = {
        var tableView = UITableView()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.tableFooterView = UIView()
        tableView.backgroundColor = BgColor
        tableView.registerClass(SCE_BookListTableViewCell.self, forCellReuseIdentifier: "SCE_BookListTableViewCell")
        return tableView
    }()
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        self.tableView.separatorInset = UIEdgeInsetsMake(0,0,0,0)
        self.tableView.layoutMargins = UIEdgeInsetsMake(0,0,0,0)
    }
}

extension SCE_BookListViewController:UITableViewDelegate,UITableViewDataSource {
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return self.e_BookListArray.count
    }
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let itemModel = self.e_BookListArray[indexPath.row]
        
        let cell = tableView.dequeueReusableCellWithIdentifier("SCE_BookListTableViewCell", forIndexPath: indexPath) as! SCE_BookListTableViewCell
        cell.itemModel = itemModel
        return cell
    }
    
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 120
    }
    func tableView(tableView: UITableView, willDisplayCell cell: UITableViewCell, forRowAtIndexPath indexPath: NSIndexPath) {
        
        cell.separatorInset = UIEdgeInsetsZero
        cell.layoutMargins = UIEdgeInsetsZero
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let hhh = SCE_BookOpenViewController()
        self.navigationController?.pushViewController(hhh, animated: true)
    }
    
}