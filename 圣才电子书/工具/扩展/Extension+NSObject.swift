//
//  Extension+NSObject.swift
//  SCDZS
//
//  Created by 周磊 on 16/7/1.
//  Copyright © 2016年 周磊. All rights reserved.
//


import UIKit

extension NSObject{
    
    class func objectWithKeyValues(keyValues:NSDictionary) -> AnyObject{
        
        let model = self.init()
        //存放属性的个数
        var outCount:UInt32 = 0
        //获取所有的属性
        let properties = class_copyPropertyList(self.classForCoder(), &outCount)
        //遍历属性
        for i in 0 ..< Int(outCount) {
            //获取第i个属性
            let property = properties[i]
            //得到属性的名字
            let key = NSString(CString: property_getName(property), encoding: NSUTF8StringEncoding)!
            
            //判断字典的所有的key是否和属性一样
            let isContains  =  keyValues.allKeys.contains { (element) -> Bool in
                
                if element as! NSObject == key {
                    return true
                }else {
                    return false
                }
            }
            
            //字典的key和属性一样才能赋值
            if isContains {
                //一般来说json模型里的所有对象的属性不是String就是Number
                let  keyValuesString = keyValues[key]
                
                if let value = keyValuesString{
                    //为model类赋值
                    model.setValue(value, forKey: key as String)
                }
            }
        }
        return model
    }
}


