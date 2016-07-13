//
//  SCHomeModel.swift
//  SCDZS
//
//  Created by 周磊 on 16/7/7.
//  Copyright © 2016年 周磊. All rights reserved.
//

import UIKit

enum SCHomeCellType:Int{
    /// 搜索导航
    case SearchNavigation = 31
    /// 图片轮播
    case  PictureBy = 11
    /// 【旧版过渡】搜索+图片轮播
    case  OldPictureBy = 10
    ///  热点、爆笑、奇闻、测试
    case  Discover = 40
    ///  今日热点
    case  HotSpots = 90
    ///  产品分类导航
    case  CategoryNavigation = 42
    ///  主要的
    case  MainCell = 20
    /// 间隙
    case  spaceCell = 10086
    
}



class SCHomeModel: NSObject {

    var cellType = SCHomeCellType.MainCell
    //model_name
    var model_name:String?
    //模型id
    var model_id:String?
    //模型类型
    var model_type:String?
    //数据数组
    var tabs:NSArray?
    //图片轮播的数据数组
    var rolling_pics:NSArray?
    //今日热点图片地址
    var pic_url:String?
    //今日热点数据字典
    var interface_data:NSDictionary?
    //主要cell的第一个数据源数组
    var books:NSArray?

    var href_link:String?

    //首页导航模型数组
    var homeNavigationModelArray = [SCHomeNavigationModel]()
    //首页图片轮播模型数组
    var homeCarouselModelArray = [SCHomeCarouselModel]()
    //首页热点、爆笑、奇闻、测试模型数组
    var homeDiscoverModelArray = [SCHomeDiscoverModel]()
    //首页今日热点模型数组
    var homeHotSpotsModelArray = [SCHomeHotSpotsModel]()
    //首页产品分类导航模型数组
    var homeCategoryNavigationModelArray = [SCHomeCategoryNavigationModel]()
    //首页主要模型数组
    var homeMainModelArray = [SCHomeMainModel]()

}


//首页导航模型
class SCHomeNavigationModel: NSObject {
    /// 图片url
    var tab_icon:String?
    /// 名称
    var tab_name:String?
}

//首页图片轮播模型
class SCHomeCarouselModel: NSObject {
    /// url地址
    var href_link:String?
    /// 图片地址
    var pic_url:String?
    /// 标题
    var title:String?
}

//首页热点、爆笑、奇闻、测试模型
class SCHomeDiscoverModel: NSObject {
    /// url地址
    var href_link:String?
    /// 图片地址
    var tab_icon:String?
    /// 标题
    var tab_name:String?
}

//今日热点模型
class SCHomeHotSpotsModel: NSObject {
    
    /// url地址
    var url:String?
    /// 图片地址
    var imgUrl:String?
    /// 标题
    var title:String?
    /// id
    var id:NSNumber?
    /// 时间
    var publishTime:String?
    
    var viewNum:NSNumber?

}

//首页产品分类导航模型
class SCHomeCategoryNavigationModel: NSObject {
    /// id
    var id:String?
    ///
    var hassubtype:String?
    /// 标题
    var name:String?
}


class SCHomeMainModel: NSObject {
    
    var titleName:String?
    var tab_id:String?
    var homeBooksModelArray = [SCHomeBooksModel]()
    
}



//首页书籍模型
class SCHomeBooksModel: NSObject {
    
    /// 背景图片
    var bgImg:String?
    /// 应该是上传时间
    var date:String?
    /// id
    var id:NSNumber?
    /// 名字
    var name:String?
    /// 图片地址
    var pic:String?
    var pubDate:String?
    /// 大小
    var size:NSNumber?
    /// 类型名称
    var typename:String?
    /// 类型
    var type:NSNumber?

}


