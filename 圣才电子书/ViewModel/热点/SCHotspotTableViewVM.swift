//
//  SCHotspotTableViewVM.swift
//  SCDZS
//
//  Created by 周磊 on 16/7/4.
//  Copyright © 2016年 周磊. All rights reserved.
//

import UIKit

class SCHotspotTableViewVM: NSObject {
    
    internal  var requestCommand:RACCommand!
    
    override init() {
        super.init()
        
        
    }
    
    var categroyId :String = "" {
        
        didSet {
            
            initialBind(categroyId)
        }
    }
    
    
    func initialBind(categroyId:String) {
        
        let url = "http://app.100xuexi.com/app/TalkHandler/TalkQuery.ashx?method=GetAllByParam3&noCache=1&CategoryID=\(categroyId)&deviceNo=ios&pageIndex=1&pageSize=10&studyNumber=2742573&type=0"
        
        //获取所有类型的数据
        requestCommand = RACCommand.init(signalBlock: { (input) -> RACSignal! in
            
            let signal = RACSignal.createSignal({ (subscriber) -> RACDisposable! in
                
                request.defaultInstance().GetRequest(url).responseJSON { (response) in
                    
                    switch response.result  {
                    case .Success:
                        
                        guard let JsonData = response.result.value as? NSDictionary else { return }
                        
                        let talks = JsonData["talks"] as? [NSDictionary]
                        
                        var talksModelArray = [talksModel]()
                        
                        for dict in talks! {
                            //字典转模型
                            let hotspotTalksModel = talksModel.objectWithKeyValues(dict) as! talksModel
                            
                            if hotspotTalksModel.mediaImgList?.count > 2 {
                                hotspotTalksModel.cellType = CellType.image
                            }else if hotspotTalksModel.mediaImgList?.count > 0 && hotspotTalksModel.mediaImgList?.count < 3 {
                                hotspotTalksModel.cellType = CellType.graphic

                            }else if hotspotTalksModel.mediaImgList?.count == 0 {
                                hotspotTalksModel.cellType = CellType.linking
                                
                            }
                            
                            
                            talksModelArray.append(hotspotTalksModel)
                        }
                        
                        subscriber.sendNext(talksModelArray)
                        
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
