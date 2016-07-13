//
//  SCHomeVM.swift
//  SCDZS
//
//  Created by 周磊 on 16/7/7.
//  Copyright © 2016年 周磊. All rights reserved.
//

import UIKit

class SCHomeVM: NSObject {

    override init() {
        super.init()

        
    }


    func requestHomeDataSouce(successBlock:(successModelArray:[SCHomeModel])->Void,errorBlock:(error:NSError)->Void) {
        
        request.defaultInstance().GetRequest(homeUrl).responseJSON { (response) in
            
            switch response.result  {
            case .Success:
                
                guard let JsonData = response.result.value as? NSDictionary else { return }
                
                let pageconf = JsonData["pageconf"] as? [NSDictionary]
                
               let homeModelArray =  self.buildNormalCellProperties(pageconf!)
                
                successBlock(successModelArray: homeModelArray)

            case .Failure(let error):
                
                errorBlock(error: error)
            }
        }
    }
    
    /**
     处理数据
     */
      func buildNormalCellProperties(pageconfArray:[NSDictionary])->[SCHomeModel] {

        var homeModelArray = [SCHomeModel]()
        
        for itemDict in pageconfArray {
            
            let model_type = itemDict["model_type"] as! String
            let homeModel = SCHomeModel()
            homeModel.model_name = itemDict["model_name"] as? String
            homeModel.model_id = itemDict["model_id"] as? String

            if Int(model_type) == 31 {/// 搜索导航
                homeModel.cellType = SCHomeCellType.SearchNavigation
                
                if (itemDict["tabs"] as? [NSDictionary])?.count > 0 {
                    
                    for dict in (itemDict["tabs"] as? [NSDictionary])! {
                        let navigationModel =  SCHomeNavigationModel()
                        navigationModel.tab_icon = dict["tab_icon"] as? String
                        navigationModel.tab_name = dict["tab_name"] as? String
                        homeModel.homeNavigationModelArray.append(navigationModel)
                    }
                }
            }
            
            if Int(model_type) == 11 {/// 图片轮播
                homeModel.cellType = SCHomeCellType.PictureBy
                
                if (itemDict["rolling_pics"] as? [NSDictionary])?.count > 0 {
                    
                    for dict in (itemDict["rolling_pics"] as? [NSDictionary])! {
                        
                        let carouselModel =  SCHomeCarouselModel()
                        carouselModel.href_link = dict["href_link"] as? String
                        carouselModel.pic_url = dict["pic_url"] as? String
                        carouselModel.title = dict["title"] as? String
                        homeModel.homeCarouselModelArray.append(carouselModel)
                    }
                }
            }
            
            
            if Int(model_type) == 10 {/// 旧图片轮播
                homeModel.cellType = SCHomeCellType.OldPictureBy
                
                if (itemDict["rolling_pics"] as? [NSDictionary])?.count > 0 {
                    
                    for dict in (itemDict["rolling_pics"] as? [NSDictionary])! {
                        
                        let carouselModel =  SCHomeCarouselModel()
                        carouselModel.href_link = dict["href_link"] as? String
                        carouselModel.pic_url = dict["pic_url"] as? String
                        carouselModel.title = dict["title"] as? String
                        homeModel.homeCarouselModelArray.append(carouselModel)
                    }
                }
            }
            
        
            if Int(model_type) == 40 {///  热点、爆笑、奇闻、测试
                homeModel.cellType = SCHomeCellType.Discover
                
                if (itemDict["tabs"] as? [NSDictionary])?.count > 0 {
                    
                    for dict in (itemDict["tabs"] as? [NSDictionary])! {
                        let discoverModel =  SCHomeDiscoverModel()
                        
                        if dict["href_link_type"] as? String == "0" {
                            discoverModel.href_link = nil
                            
                        }else {
                            discoverModel.href_link = dict["href_link"] as? String

                        }
                        discoverModel.tab_icon = dict["tab_icon"] as? String
                        discoverModel.tab_name = dict["tab_name"] as? String
                        homeModel.homeDiscoverModelArray.append(discoverModel)
                    }
                }
            }

            if Int(model_type) == 90 {///  热点、爆笑、奇闻、测试
                homeModel.cellType = SCHomeCellType.HotSpots
                homeModel.pic_url = itemDict["pic_url"] as? String
                
                let interface_dataDict = itemDict["interface_data"] as? NSDictionary
                let listArray = interface_dataDict!["list"] as? [NSDictionary]
                
                for listDict in listArray! {
                    let hotSpotsModel = SCHomeHotSpotsModel.objectWithKeyValues(listDict) as! SCHomeHotSpotsModel
                    homeModel.homeHotSpotsModelArray.append(hotSpotsModel)
                }
            }

            
            if Int(model_type) == 42 {///  产品分类导航
                homeModel.cellType = SCHomeCellType.CategoryNavigation
                
                if (itemDict["tabs"] as? [NSDictionary])?.count > 0 {
                    
                    for tabsDict in (itemDict["tabs"] as? [NSDictionary])! {
                        
                        let href_linkDict = tabsDict["href_link"] as? NSDictionary
                        
                        let parasArray = href_linkDict!["paras"] as? [NSDictionary]
                        
                        let categoryNavigationModel = SCHomeCategoryNavigationModel()
                        
                        for _ in parasArray! {
                            
                            if parasArray?.count > 0 {
                                categoryNavigationModel.id = parasArray![0]["value"] as? String
                            }
                            if parasArray?.count > 1 {
                                categoryNavigationModel.name = parasArray![1]["value"] as? String
                            }
                            if parasArray?.count > 2 {
                                categoryNavigationModel.hassubtype = parasArray![2]["value"] as? String
                            }
                        }
                        homeModel.homeCategoryNavigationModelArray.append(categoryNavigationModel)
                    }
                    
                }
                
            }

            
            if Int(model_type) == 20 {/// 主要的
                homeModel.cellType = SCHomeCellType.MainCell
                
               let homeMainModel  = SCHomeMainModel()
                homeMainModel.tab_id =  itemDict["title_id"] as? String
                homeMainModel.titleName = itemDict["title"] as? String
                let booksArray = itemDict["books"] as? [NSDictionary]
                for booksDict in booksArray! {
                    let homeBooksModel = SCHomeBooksModel.objectWithKeyValues(booksDict) as! SCHomeBooksModel
                    homeMainModel.homeBooksModelArray.append(homeBooksModel)
                }
                homeModel.homeMainModelArray.append(homeMainModel)
                
                
                if (itemDict["tabs"] as? [NSDictionary])?.count > 0 {
                    
                    for tabsDict in (itemDict["tabs"] as? [NSDictionary])! {
                        
                    let tabsHomeMainModel  = SCHomeMainModel()

                        tabsHomeMainModel.tab_id = tabsDict["tab_id"] as? String
                        tabsHomeMainModel.titleName = tabsDict["tab_name"] as? String

                        let tabsBooksArray = tabsDict["books"] as? [NSDictionary]
                        for tabsBooksDict in tabsBooksArray! {
                            let tabsHomeBooksModel = SCHomeBooksModel.objectWithKeyValues(tabsBooksDict) as! SCHomeBooksModel
                            tabsHomeMainModel.homeBooksModelArray.append(tabsHomeBooksModel)
                        }
                        homeModel.homeMainModelArray.append(tabsHomeMainModel)
                    }
                }
            }
            
            homeModelArray.append(homeModel)
            /// 添加间隙
            let spaceHomeModel = SCHomeModel()
            spaceHomeModel.cellType = SCHomeCellType.spaceCell
            homeModelArray.append(spaceHomeModel)
        }
  
        return homeModelArray
    }
}