//
//  SCE_BookDetailsVM.swift
//  SCDZS
//
//  Created by 周磊 on 16/7/19.
//  Copyright © 2016年 周磊. All rights reserved.
//

import UIKit

class SCE_BookClassifiedVM: NSObject {

    internal  var requestCommand:RACCommand!

    internal  var listRequestCommand:RACCommand!

    
     init(booksId:String) {
        super.init()
        
        initialBind(booksId)
        listRequest(booksId)

    }
    
    func initialBind(booksId:String){
        
        
        let url = "http://emobile.100xuexi.com/api/v1/book_class.php?&level=1&main=\(booksId)"
        
        requestCommand = RACCommand.init(signalBlock: { (input) -> RACSignal! in
            
             let signal = RACSignal.createSignal({ (subscriber) -> RACDisposable! in
                
                //发送get请求
                request.defaultInstance().GetRequest(url).responseJSON { (response) in
                    
                    switch response.result  {
                    case .Success:
                        
                        guard let JsonData = response.result.value as? NSDictionary else { return }
                        
                        /// 数组里都是字典
                        let book_classArray = JsonData["book_class"] as? [NSDictionary]
                        
                        var e_BookClassifiedArray = [SCE_BookClassifiedModel]()
                        
                        for dict in book_classArray! {
                            
                            //字典转模型
                            let e_BookClassifiedModel = SCE_BookClassifiedModel.objectWithKeyValues(dict) as! SCE_BookClassifiedModel
                            
                            let itemArray = dict["item"] as? NSArray
                            
                            for itemDict in itemArray! {
                                
                                //字典转模型
                                let itemModel = SCE_BookClassifiedItemModel.objectWithKeyValues(itemDict as! NSDictionary) as? SCE_BookClassifiedItemModel
                                
                                e_BookClassifiedModel.itemArray.append(itemModel!)
                            }
                            
                            e_BookClassifiedArray.append(e_BookClassifiedModel)
                        }
                         /**
                         *  把最终的模型数组发送出去
                         *
                         *  @param myCenterModelArray 模型数组
                         *
                         */
                        subscriber.sendNext(e_BookClassifiedArray)
                        /**
                         *  数据发送完成
                         */
                        subscriber.sendCompleted()
                        
                    case .Failure(let error):
                        
                        /**
                         *  发送错误的信息
                         */
                        subscriber.sendError(error)
                    }
                }
                return nil
            })
            return signal
            
        })
    }
    
    func listRequest(booksId:String) {
        
        let listUrl = "http://app.100xuexi.com/App/AppEbookQuery.ashx?PageSize=2000&book_class_id=\(booksId)&itemstart=0&order=0"

        listRequestCommand = RACCommand.init(signalBlock: { (input) -> RACSignal! in
            
            let signal = RACSignal.createSignal({ (subscriber) -> RACDisposable! in
                
                //发送get请求
                request.defaultInstance().GetRequest(listUrl).responseJSON { (response) in
                    
                    switch response.result  {
                    case .Success:
                        
                        guard let JsonData = response.result.value as? NSDictionary else { return }
                        
                        let bookDict = JsonData["book"] as? NSDictionary
                        let itemArray = bookDict!["item"] as? [NSDictionary]
                        var e_BookListArray = [SCE_BookListModel]()
                        
                        for dict in itemArray! {
                            //字典转模型
                            let e_BookListModel = SCE_BookListModel.objectWithKeyValues(dict) as! SCE_BookListModel
                       
                            e_BookListArray.append(e_BookListModel)
                        }
                        /**
                         *  把最终的模型数组发送出去
                         */
                        subscriber.sendNext(e_BookListArray)
                        /**
                         *  数据发送完成
                         */
                        subscriber.sendCompleted()
                        
                    case .Failure(let error):
                        
                        /**
                         *  发送错误的信息
                         */
                        subscriber.sendError(error)
                    }
                }
                return nil
            })
            return signal
            
        })
        
    }
}
