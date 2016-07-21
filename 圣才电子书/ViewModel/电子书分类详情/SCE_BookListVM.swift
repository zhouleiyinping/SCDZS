//
//  SCE_BookListVM.swift
//  SCDZS
//
//  Created by 周磊 on 16/7/19.
//  Copyright © 2016年 周磊. All rights reserved.
//

import UIKit

class SCE_BookListVM: NSObject {

    internal  var listRequestCommand:RACCommand!

    init(booksId:String) {
        super.init()
        
        listRequest(booksId)
        
    }
    
    func listRequest(booksId:String) {
        
        let listUrl = "http://app.100xuexi.com/App/AppEbookQuery.ashx?PageSize=20&book_class_id=\(booksId)&itemstart=0&order=0"
        
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
