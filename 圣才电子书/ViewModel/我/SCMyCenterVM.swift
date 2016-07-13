//
//  SCMyCenterRequest.swift
//  圣才电子书
//
//  Created by 周磊 on 16/6/18.
//  Copyright © 2016年 周磊. All rights reserved.
//  我页面的网络请求

import UIKit
import Alamofire



class SCMyCenterVM: NSObject {
    
  internal  var requestCommand:RACCommand!
    
    override init() {
        super.init()
        
        initialBind()
    }
    
    func initialBind() {
        
        requestCommand = RACCommand.init(signalBlock: { (input) -> RACSignal! in
            
            // 执行命令
            // 发送请求
            // 创建信号 把发送请求的代码包装到信号里面。
            
            let signal = RACSignal.createSignal({ (subscriber) -> RACDisposable! in
                
                //发送get请求
                request.defaultInstance().GetRequest(myCenterUrl).responseJSON { (response) in
                    
                    switch response.result  {
                    case .Success:
                        /// 使用RAC，必须注明所有的对象的属性，不然RAC会统一置成RACChannelTerminal
                        
                        /// 获取的数据是字典
                        guard let JsonData = response.result.value as? NSDictionary else { return }
                        
                        /// 数组里都是字典
                        let pageconf = JsonData["pageconf"] as? [NSDictionary]
                        
                        var myCenterModelArray = [SCMyCenterModel]()
                        
                        for dict in pageconf! {
                            
                            //字典转模型
                            let myCenterModel = SCMyCenterModel.objectWithKeyValues(dict) as! SCMyCenterModel
                            
                            let tabsArray = dict["tabs"] as? NSArray
                            
                            for tabsDict in tabsArray! {
                                
                                //字典转模型
                                let myCenterModelTabs = SCMyCenterModelTabs.objectWithKeyValues(tabsDict as! NSDictionary) as? SCMyCenterModelTabs
                                
                                myCenterModel.tabsArray.append(myCenterModelTabs!)
                            }
                            
                            myCenterModelArray.append(myCenterModel)
                        }

                        /**
                         *  把最终的模型数组发送出去
                         *
                         *  @param myCenterModelArray 模型数组
                         *
                         */
                        subscriber.sendNext(myCenterModelArray)
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

