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
        
        initialBind()
    }
    
    
    func requesrHotspotNews(categoryID:String,pageIndex:String,successBlock:(successModelArray:[talksModel])->Void,errorBlock:(error:NSError)->Void) {
        
        let url = "http://app.100xuexi.com/app/TalkHandler/TalkQuery.ashx?method=GetAllByParam3&noCache=1&CategoryID=\(categoryID)&deviceNo=ios&pageIndex=\(pageIndex)&pageSize=10&studyNumber=2742573&type=0"
        
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
                
                successBlock(successModelArray: talksModelArray)

                
            case .Failure(let error):
                
                errorBlock(error: error)
            }
        }
        
    }
    
    
    func initialBind() {
        
        //获取所有类型的数据
        requestCommand = RACCommand.init(signalBlock: { (input) -> RACSignal! in
            
            let categroyId = input as! String
             let topArticleUrl = "http://app.100xuexi.com/App/ArticleHandle.ashx/?CategroyId=\(categroyId)&PageSize=10&method=GetTopArticle&noCache=1&PageIndex=0"
            
            let signal = RACSignal.createSignal({ (subscriber) -> RACDisposable! in
                
                request.defaultInstance().GetRequest(topArticleUrl).responseJSON { (response) in
                    
                    switch response.result  {
                    case .Success:
                        
                        guard let JsonData = response.result.value as? NSDictionary else { return }
                        
                        let listArray = JsonData["list"] as? [NSDictionary]
                        
                        var topArticleModelArray = [topArticleModel]()
                        
                        for dict in listArray! {
                            //字典转模型
                            let topArticle = topArticleModel.objectWithKeyValues(dict) as! topArticleModel
                            
                            topArticleModelArray.append(topArticle)
                        }
                        
                        subscriber.sendNext(topArticleModelArray)
                        
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
