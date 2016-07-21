//
//  SCE_BookClassifiedModel.swift
//  SCDZS
//
//  Created by 周磊 on 16/7/19.
//  Copyright © 2016年 周磊. All rights reserved.
//

import UIKit

class SCE_BookClassifiedModel: NSObject {

    var EBookNum:NSNumber?
    var id:NSNumber?
    var name:String?
    var short_name:String?
    var son:String?
    var itemArray = [SCE_BookClassifiedItemModel]()
    
}

class SCE_BookClassifiedItemModel: NSObject {
    
    var EBookNum:NSNumber?
    var id:NSNumber?
    var name:String?
    var short_name:String?
    var son:String?
    
}

class SCE_BookListModel: NSObject {
    
    var bgImg:String?
    var collID:NSNumber?
    var date:String?
    var downum:NSNumber?
    var id:NSNumber?
    var name:String?
    var pic:String?
    var price:String?
    var size:NSNumber?
    var typename:String?
    var type:NSNumber?

}

