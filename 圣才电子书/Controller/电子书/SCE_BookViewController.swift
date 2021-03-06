//
//  SCE-BookViewController.swift
//  圣才电子书
//
//  Created by 周磊 on 16/6/17.
//  Copyright © 2016年 周磊. All rights reserved.
//

import UIKit

class SCE_BookViewController: SCBaseViewController{
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.view.backgroundColor = BgColor
        
        self.titleView.hidden = true
        self.view.addSubview(e_bookTitleView)
        e_bookTitleView.snp.makeConstraints { (make) in
            make.top.left.right.equalTo(self.view).offset(0)
            make.height.equalTo(NavigationH)
        }
        
        self.view.addSubview(e_BookCV)
        e_BookCV.snp.makeConstraints { (make) in
            make.left.right.equalTo(self.view).offset(0)
            make.top.equalTo(self.view).offset(NavigationH)
            make.bottom.equalTo(self.view).offset(-50)
        }
        
        e_bookTitleView.searchImageButton.rac_signalForControlEvents(UIControlEvents.TouchUpInside).subscribeNext { (value) in
            SCLog("点击了搜索按钮")
            
        }
        
        //switchToLatest获取信号中的信号的最新的信号
        e_BookCV.CVSignal.switchToLatest().subscribeNext { (ClickSignal) in
            
            SCLog("点击了查看我的电子书")

        }
        
        e_BookCV.DidSelectItemSignal.subscribeNext { (value) in
            
            let model = value as! SCE_BookModelItem
            
                self.showHUD()
            
                let e_BookClassifiedRequest = SCE_BookClassifiedVM.init(booksId: String(model.id!))
                
                var e_BookClassifiedArray = [SCE_BookClassifiedModel]()
                // 发送请求
                let signal = e_BookClassifiedRequest.requestCommand.execute(nil)
                signal.subscribeNext({ (value) in
                    e_BookClassifiedArray = value as! [SCE_BookClassifiedModel]
                    
                    }, error: { (error) in
                        self.showErrorHUDWithMessage("哎呀，出错了")
                    }, completed: {
                        self.hideHUD()
                        
                        if model.son! == "Y" {
                            
                            if Int(model.EBookNum!) > 0 {
                                let e_BookClassifiedView = SCE_BookClassifiedViewController()
                                e_BookClassifiedView.titleLabel.text = model.name!
                                e_BookClassifiedView.e_BookClassifiedArray = e_BookClassifiedArray
                                self.navigationController?.pushViewController(e_BookClassifiedView, animated: true)
                            }else {
                                
                                self.showOnlyWords("本分类下暂无内容，请查看其它分类")
                            }

                        } else {
                        
                            if Int(model.EBookNum!) > 0 {
                                let e_BookListView = SCE_BookListViewController()
                                e_BookListView.titleLabel.text = model.name!
                                e_BookListView.bookId = String(model.id!)
                                self.navigationController?.pushViewController(e_BookListView, animated: true)
                            }else {
                                
                                self.showOnlyWords("本分类下暂无内容，请查看其它分类")
                            }
                        }
                })
        }
        
        self.showHUD()
        requestDataSouce()
        
        
    }

    // MARK: - 请求数据
    func requestDataSouce() {
        
        weak var wself = self
        // 发送请求
        let signal = self.e_BookRequest.requestCommand.execute(nil)
        signal.subscribeNext({ (dataArray) in
            
            //强转成RACTuple，不然真机上会报ambiguous use of subscript错误，但是模拟机上不会，不知道什么原因。。。。。。
            let dataTuples = dataArray as! RACTuple
            wself!.e_BookCV.e_BookModelArray = (dataTuples[0] as? [SCE_BookModel])!
            wself!.e_BookCV.totalNumMode = (dataTuples[1] as? SCE_BookTotalNumMode)!
            
            }, error: { (error) in
                wself?.showErrorHUDWithMessage("哎呀，出错了")
        }) {
            wself?.hideHUD()
        }
        
    }
    
    // MARK: - SCE_BookVM
    lazy var e_BookRequest:SCE_BookVM = {
        let e_BookRequest = SCE_BookVM()
        return e_BookRequest
    }()
   
    // MARK: - SCE_BookTitleView
    lazy var e_bookTitleView:SCE_BookTitleView = {
        var e_bookTitleView = SCE_BookTitleView()
        e_bookTitleView.backgroundColor = RGB(217, g: 40, b: 53)
        e_bookTitleView.titleLabel.text = "电子书分类"
        return e_bookTitleView
    }()
    
    
    lazy var e_BookCV:SCE_BookCV = {
        var e_BookCV = SCE_BookCV()
        e_BookCV.backgroundColor = UIColor.cyanColor()
        
        return e_BookCV
    }()
}
