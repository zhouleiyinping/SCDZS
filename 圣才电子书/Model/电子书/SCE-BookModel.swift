//
//  SCE-BookModel.swift
//  SCDZS
//
//  Created by 周磊 on 16/7/1.
//  Copyright © 2016年 周磊. All rights reserved.
//

import UIKit

class SCE_BookModel: NSObject {

    var EBookNum:NSNumber?
    var id:NSNumber?
    var name:String?
    var short_name:String?
    var son:String?
    var itemsArray = [SCE_BookModelItem]()
}

class SCE_BookModelItem: NSObject {
    
    var EBookNum:NSNumber?
    var id:NSNumber?
    var name:String?
    var short_name:String?
    var son:String?
}


class SCE_BookTotalNumMode: NSObject {
    
    var ebookCT:NSNumber?
    var tkCT:NSNumber?
    var videoCT:NSNumber?
  
}