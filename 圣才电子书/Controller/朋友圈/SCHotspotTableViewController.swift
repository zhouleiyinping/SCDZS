//
//  SCHotspotTableViewController.swift
//  SCDZS
//
//  Created by 周磊 on 16/7/4.
//  Copyright © 2016年 周磊. All rights reserved.
//

import UIKit

class SCHotspotTableViewController: UITableViewController {

    var categroyId:String!
    var dataSouceArray = [talksModel]()

    
    // MARK: - SCHotspotTableViewVM
    lazy var hotspotTableViewVM:SCHotspotTableViewVM = {
        let hotspotTableViewVM = SCHotspotTableViewVM()
        hotspotTableViewVM.categroyId = self.categroyId
        return hotspotTableViewVM
    }()
    
    // MARK: - 请求数据
    func requestDataSouce() {
        
        weak var wself = self
        // 发送请求
        let signal = self.hotspotTableViewVM.requestCommand.execute(nil)
        signal.subscribeNext({ (dataArray) in
            
            wself!.dataSouceArray = (dataArray as? [talksModel])!
            
            
            }, error: { (error) in
                wself?.showErrorHUDWithMessage("哎呀，出错了")
        }) {
            wself?.hideHUD()
            wself!.tableView.reloadData()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.registerClass(SCHotspotImageCell.self, forCellReuseIdentifier: "SCHotspotImageCell")
        tableView.registerClass(SCHotspotGraphicCell.self, forCellReuseIdentifier: "SCHotspotGraphicCell")
        tableView.registerClass(SCHotspotLinkingCell.self, forCellReuseIdentifier: "SCHotspotLinkingCell")

        tableView.tableFooterView = UIView()
        
        self.showHUD()
        requestDataSouce()
        
    }
   
}
// MARK: - Table view data source
extension SCHotspotTableViewController{
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        
        return 1
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return dataSouceArray.count
    }
    
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let talksModel =  dataSouceArray[indexPath.row]
        
        switch talksModel.cellType {
        case .image:
            
            let  cell = tableView.dequeueReusableCellWithIdentifier("SCHotspotImageCell", forIndexPath: indexPath) as! SCHotspotImageCell
            cell.selectionStyle = UITableViewCellSelectionStyle.None
            cell.cellTalksModel = talksModel
            return cell
            
            
        case .graphic:
            
            let  cell = tableView.dequeueReusableCellWithIdentifier("SCHotspotGraphicCell", forIndexPath: indexPath) as! SCHotspotGraphicCell
            cell.selectionStyle = UITableViewCellSelectionStyle.None
            cell.cellTalksModel = talksModel

            return cell
            
        default:
            
            let  cell = tableView.dequeueReusableCellWithIdentifier("SCHotspotLinkingCell", forIndexPath: indexPath) as! SCHotspotLinkingCell
            cell.selectionStyle = UITableViewCellSelectionStyle.None
            cell.cellTalksModel = talksModel

            return cell
            
        }
        
        
    }
    
//    override func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
//        return 200
//    }
//    
//    override func tableView(tableView: UITableView, viewForHeaderInSection section: Int) -> UIView {
//        
//        let headerView = UIView()
//        headerView.backgroundColor = UIColor.cyanColor()
//        return headerView
//    }
    
    override  func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        let talksModel =  dataSouceArray[indexPath.row]

        switch talksModel.cellType {
        case .linking:
            return 80
        case .image:
            return 180
        default:
           return 130
        }
    }
    
    
}
