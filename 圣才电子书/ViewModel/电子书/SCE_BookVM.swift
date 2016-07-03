//
//  SCE_BookVM.swift
//  SCDZS
//
//  Created by 周磊 on 16/7/1.
//  Copyright © 2016年 周磊. All rights reserved.
//

import UIKit

class SCE_BookVM: NSObject {

    internal  var requestCommand:RACCommand!
    
    
    override init() {
        super.init()
        
        initialBind()
    }
    
    func initialBind(){
        
        
        requestCommand = RACCommand.init(signalBlock: { (input) -> RACSignal! in
            
            
            let numberSignal = RACSignal.createSignal({ (subscriber) -> RACDisposable! in
                
                //发送get请求
                request.defaultInstance().GetRequest(e_bookNumberUrl).responseJSON { (response) in
                    
                    switch response.result  {
                    case .Success:
                        
                        /// 获取的数据是字典
                        guard let JsonData = response.result.value as? NSDictionary else { return }
                        
                        /// 数组里都是字典
                        let totalNum = JsonData["totalNum"] as? NSDictionary
                        
                        let e_BookTotalNumMode = SCE_BookTotalNumMode.objectWithKeyValues(totalNum!) as? SCE_BookTotalNumMode
                        
                        /**
                         *  把最终的模型数组发送出去
                         */
                        subscriber.sendNext(e_BookTotalNumMode)
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
            
            
            // 执行命令
            // 发送请求
            // 创建信号 把发送请求的代码包装到信号里面。
            
            let signal = RACSignal.createSignal({ (subscriber) -> RACDisposable! in
                
                //发送get请求
                request.defaultInstance().GetRequest(E_BookUrl).responseJSON { (response) in
                    
                    switch response.result  {
                    case .Success:
                        /// 使用RAC，必须注明所有的对象的属性，不然RAC会统一置成RACChannelTerminal
                        
                        /// 获取的数据是字典
                        guard let JsonData = response.result.value as? NSDictionary else { return }
                        
                        /// 数组里都是字典
                        let book_class = JsonData["book_class"] as? [NSDictionary]
                        
                        var e_BookModelArray = [SCE_BookModel]()
                        
                        for dict in book_class! {
                            
                            //字典转模型
                            let e_BookModel = SCE_BookModel.objectWithKeyValues(dict) as! SCE_BookModel
                            
                            let itemsArray = dict["item"] as? NSArray
                            
                            for itemsDict in itemsArray! {
                                
                                //字典转模型
                                let e_BookModelItem = SCE_BookModelItem.objectWithKeyValues(itemsDict as! NSDictionary) as? SCE_BookModelItem
                                
                                e_BookModel.itemsArray.append(e_BookModelItem!)
                            }
                            
                            e_BookModelArray.append(e_BookModel)
                        }
                        
                        /**
                         *  把最终的模型数组发送出去
                         */
                        subscriber.sendNext(e_BookModelArray)
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
            return signal.zipWith(numberSignal)
            
        })
        
    }
}
