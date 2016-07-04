//
//  SCHotspotModel.swift
//  SCDZS
//
//  Created by 周磊 on 16/7/3.
//  Copyright © 2016年 周磊. All rights reserved.
//

import UIKit

// MARK: - 首页cell类型
enum CellType {
    case image
    case graphic
    case linking
}

class SCHotspotModel: NSObject {

    
    
    
}



class topArticleModel: NSObject {
    
    var url:String?
    var imgUrl:String?
    var title:String?
}

/// 所有种类
class allCategory: NSObject {
    
    var Id:NSNumber?
    var Name:String?
    
}

/// 所有种类
class talksModel: NSObject {
    
//    /// 热点id
//    var talkID:NSNumber?
//    /// 热点目标
//    var talkTarget:NSNumber?
//    /// 热点类型
//    var talkType:String?
//    /// 热点时间
//    var talkTime:String?
//    /// 热点时间1
//    var device:String?
//    var content:String?
////    var good:NSNumber?
////    var bad:NSNumber?
////    var images:NSArray?
//    var replies:NSArray?
//    var userID:NSNumber?
//    var userHead:String?
//    var productPlat:NSNumber?
//    var productID:NSNumber?
//    var productUrl:String?
//    var page:NSNumber?
//    var paperID:String?
//    var questionID:String?
//    var Address:String?
//    var Latitude:String?
//    var Longitude:String?
//    var eBookExt:String?
//    var userCount:NSNumber?
//    var userList:NSArray?
//    var userAddGood:Bool?
//    var mediaTypeDisplayName:String?
//    var eBookGuid:String?
//    var eBookVersionNo:NSNumber?
//    var mediaFrom:String?
//    var mediaType:NSNumber?
//    var mediaTypeName:String?
//    var mediaUrl:String?

    var nickName:String?
    var talkTime1:String?
    var productName:String?
    var cutOut:String?
    var cellType = CellType.image
    var mediaImgList:NSArray?

}