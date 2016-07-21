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
    var currentPageIndex:Int!
    var topArticleModelArray = [topArticleModel]()

    
    // MARK: - SCHotspotTableViewVM
    lazy var hotspotTableViewVM:SCHotspotTableViewVM = {
        let hotspotTableViewVM = SCHotspotTableViewVM()
        return hotspotTableViewVM
    }()
    
    // MARK: - 请求数据
    func requestDataSouce() {
        
        weak var wself = self
    
        self.hotspotTableViewVM.requesrHotspotNews(self.categroyId, pageIndex: String(self.currentPageIndex), successBlock: { (successModelArray) in
            
            wself?.hideHUD()
            
            self.tableView.mj_header.endRefreshing()
            
            wself?.tableView.mj_footer = MJRefreshAutoNormalFooter.init(refreshingBlock: {
                
                wself?.getMoreProduct()
            })

            wself?.dataSouceArray += successModelArray
            wself?.currentPageIndex = (wself?.currentPageIndex)!+1

            wself?.setHeaderVierw(self.topArticleModelArray)
            wself?.tableView.reloadData()
            
            }) { (error) in
                wself?.hideHUD()
                self.tableView.mj_header.endRefreshing()
                wself?.showErrorHUDWithMessage("哎呀，出错了")
                wself?.hideLoadingMore()
        }
    }
    
    func  setHeaderVierw(dataArray:[topArticleModel]) {
        
        let headerView = SCHotspotHeaderView.init(frame: CGRectMake(0, 64, ScreenWidth, (CGFloat(dataArray.count) * 35)+1))
        headerView.topArticleModelArray = self.topArticleModelArray
        headerView.backgroundColor = RGB(255, g: 255, b: 255)
        headerView.delegateSignal = RACSubject.init()
        headerView.delegateSignal.subscribeNext { (value) in
            let topValue = value as! topArticleModel
            
            if !topValue.url!.isEmpty || !topValue.title!.isEmpty {
                self.goToWebView(topValue.url!,titleName: topValue.title!)
            }else {
                
                self.showErrorHUDWithMessage("骚年,SCHotspotTableViewController68行有个值为空，再检查检查吧")
            }
        }
        self.tableView.tableHeaderView = headerView
    }
    
    
    
    func requesrTopArticleDataSouce() {
        
        
        weak var wself = self
        // 发送请求
        let signal = self.hotspotTableViewVM.requestCommand.execute(self.categroyId)
        signal.subscribeNext({ (dataArray) in
            
           wself?.topArticleModelArray = dataArray as! [topArticleModel]
            
            }, error: { (error) in
                wself?.showErrorHUDWithMessage("哎呀，出错了")
        }) {
            
            wself?.requestDataSouce()
        }
        
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        currentPageIndex = 1

        tableView.registerClass(SCHotspotImageCell.self, forCellReuseIdentifier: "SCHotspotImageCell")
        tableView.registerClass(SCHotspotGraphicCell.self, forCellReuseIdentifier: "SCHotspotGraphicCell")
        tableView.registerClass(SCHotspotLinkingCell.self, forCellReuseIdentifier: "SCHotspotLinkingCell")

        tableView.tableFooterView = UIView()
        
        self.showHUD()
        requesrTopArticleDataSouce()
        
        addFooter()
        addHeader()
    }
   
    func addHeader() {
        
        self.tableView.mj_header = MJRefreshNormalHeader.init(refreshingBlock: { 
            
            if self.dataSouceArray.count > 0 {
                self.dataSouceArray.removeAll()
            }
            if self.topArticleModelArray.count > 0 {
                self.topArticleModelArray.removeAll()
            }
            self.requesrTopArticleDataSouce()
        })
    }
    
    func addFooter() {
        
        self.tableView.mj_footer = MJRefreshAutoNormalFooter.init(refreshingBlock: {
            self.getMoreProduct()
        })
    }
    /**请求更多 请求状态*/
    func getMoreProduct() {
        
        tableView.mj_footer.beginRefreshing()
        requestDataSouce()
    }
    func hideLoadingMore() {
        tableView.mj_footer.endRefreshing()
        tableView.mj_footer.hidden = true
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

    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        let talksModel =  dataSouceArray[indexPath.row]
        
        if !talksModel.cutOut!.isEmpty || !talksModel.productName!.isEmpty {
            
            let webView = SCWebViewController()
            webView.url = talksModel.cutOut!
            webView.titleLabel.text = talksModel.productName!
            self.navigationController?.pushViewController(webView, animated: true)
            
        }else {
            
            self.showErrorHUDWithMessage("骚年,SCHotspotTableViewController215行有个值为空，再检查检查吧")
        }
 
    }
    
       
    func  goToWebView(url:String,titleName:String) {
        
        let webView = SCWebViewController()
        webView.url = url
       webView.titleLabel.text = titleName
        self.navigationController?.pushViewController(webView, animated: true)
    }
    
}