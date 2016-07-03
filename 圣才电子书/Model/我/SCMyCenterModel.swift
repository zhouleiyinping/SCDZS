//
//  SCMyCenterModel.swift
//  圣才电子书
//
//  Created by 周磊 on 16/6/18.
//  Copyright © 2016年 周磊. All rights reserved.
//

import UIKit

class SCMyCenterModel: NSObject {

    var ishow_title:String?
    var model_id:String?
    var model_name:String?
    var model_order:String?
    var model_type:String?
    var position:String?
    var terminals:String?
    var title:String?
    var tabsArray = [SCMyCenterModelTabs]()
    
}

class SCMyCenterModelTabs: NSObject {
    
    var href_link_mark:String?
    var href_link_type:String?
    var ishow_reddot:String?
    var tab_desc:String?
    var tab_icon:String?
    var tab_icon_type:String?
    var tab_name:String?
    
}

