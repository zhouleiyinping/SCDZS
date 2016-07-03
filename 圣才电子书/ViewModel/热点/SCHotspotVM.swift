//
//  SCHotspotVM.swift
//  SCDZS
//
//  Created by 周磊 on 16/7/3.
//  Copyright © 2016年 周磊. All rights reserved.
//

import UIKit

class SCHotspotVM: NSObject {
    
    internal  var requestCommand:RACCommand!
    
    override init() {
        super.init()
        
        initialBind()
    }
    
    func initialBind() {
        
        requestCommand = RACCommand.init(signalBlock: { (input) -> RACSignal! in
            
            let signal = RACSignal.createSignal({ (subscriber) -> RACDisposable! in
                
                request.defaultInstance().GetRequest(hotspotGetCategoryUrl).responseJSON { (response) in
                    
                    switch response.result  {
                    case .Success:
                        
                        guard let JsonData = response.result.value as? NSDictionary else { return }
                        
                        let data = JsonData["data"] as? [NSDictionary]
                        
                        var hotspotModelArray = [allCategory]()
                        
                        for dict in data! {
                            //字典转模型
                            let hotspotModel = allCategory.objectWithKeyValues(dict) as! allCategory
                            
                            hotspotModelArray.append(hotspotModel)
                        }
                        
                        subscriber.sendNext(hotspotModelArray)
                        
                        subscriber.sendCompleted()
                        
                    case .Failure(let error):
                       
                        subscriber.sendError(error)
                    }
                }
                return nil
            })
            return signal
            
        })
        
    }
    
    
}
