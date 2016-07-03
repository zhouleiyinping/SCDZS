//
//  Public.swift
//  圣才电子书
//
//  Created by 周磊 on 16/6/18.
//  Copyright © 2016年 周磊. All rights reserved.
//

import Foundation
import UIKit


// MARK: - DEBUGLog
/**
 依次是类名.方法名.行号.内容.
 
 - parameter message:    内容.
 - parameter fileName:   类名
 - parameter methodName: 方法名
 - parameter lineNumber: 行号
 */
func SCLog<T>(message: T, fileName: String = #file, methodName: String =  #function, lineNumber: Int = #line) {
    
    #if DEBUG
        let str : String = (fileName as NSString).pathComponents.last!.stringByReplacingOccurrencesOfString("swift", withString: "")
        print("\(str)\(methodName)[\(lineNumber)]----->:\(message)")
        
    #endif
    
}

// MARK: - RGB颜色
func RGB(r:CGFloat,g:CGFloat,b:CGFloat)-> UIColor {
    
    return UIColor.init(red: r/255, green: g/255, blue: b/255, alpha: 1);
    
}

func RGBA(r:CGFloat,g:CGFloat,b:CGFloat,a:CGFloat)-> UIColor {
    
    return UIColor.init(red: r/255, green: g/255, blue: b/255, alpha: a);
    
}
// MARK: - 字体大小
func SCFont(x:CGFloat)->UIFont {
    
    return UIFont.systemFontOfSize(x)
}

// MARK: - 定义UIImage对象
func SCIMAGE(imageName:String)->UIImage {
    
    return UIImage.init(named:  imageName)!
}

// MARK: - 16进制color
func SCHexColor(hexString: String) -> UIColor{
    var cString: String = hexString.stringByTrimmingCharactersInSet(NSCharacterSet.whitespaceAndNewlineCharacterSet())
    
    if cString.characters.count < 6 {return UIColor.blackColor()}
    if cString.hasPrefix("0X") {cString = cString.substringFromIndex(cString.startIndex.advancedBy(2))}
    if cString.hasPrefix("#") {cString = cString.substringFromIndex(cString.startIndex.advancedBy(1))}
    if cString.characters.count != 6 {return UIColor.blackColor()}
    
    var range: NSRange = NSMakeRange(0, 2)
    
    let rString = (cString as NSString).substringWithRange(range)
    range.location = 2
    let gString = (cString as NSString).substringWithRange(range)
    range.location = 4
    let bString = (cString as NSString).substringWithRange(range)
    
    var r: UInt32 = 0x0
    var g: UInt32 = 0x0
    var b: UInt32 = 0x0
    NSScanner.init(string: rString).scanHexInt(&r)
    NSScanner.init(string: gString).scanHexInt(&g)
    NSScanner.init(string: bString).scanHexInt(&b)
    
    return UIColor(red: CGFloat(r)/255.0, green: CGFloat(g)/255.0, blue: CGFloat(b)/255.0, alpha: CGFloat(1))
    
}


// MARK: - 全局常用属性
public let NavigationH: CGFloat = 64
public let ScreenWidth: CGFloat = UIScreen.mainScreen().bounds.size.width
public let ScreenHeight: CGFloat = UIScreen.mainScreen().bounds.size.height
public let ScreenBounds: CGRect = UIScreen.mainScreen().bounds
public let BgColor:UIColor = RGB(240, g: 239, b: 245)


// MARK: - requestUrl
//我
public let myCenterUrl: String = "http://app.100xuexi.com/App/ServiceConfig/AppPageConfig.ashx?method=GetPageConf&pageid=6"
//发现
public let findUrl:String = "http://app.100xuexi.com/App/ServiceConfig/AppPageConfig.ashx?method=GetPageConfEx&pageid=2"
//电子书
public let E_BookUrl:String = "http://emobile.100xuexi.com/api/v1/book_class.php"
//电子书数量
public let e_bookNumberUrl:String = "http://app.100xuexi.com/App/StatisticsHandler/Statistics.ashx?method=GetTotalStatic"
//获取热点所有种类
public let hotspotGetCategoryUrl:String = "http://app.100xuexi.com/App/UserCommonCategory.ashx?method=GetCategory"
//获取热点单个种类下置顶文章
public let hotspotGetTopArticleUrl:String = "http://app.100xuexi.com/App/ArticleHandle.ashx/?CategroyId=85&PageSize=10&method=GetTopArticle&noCache=1&PageIndex=0"
//获取热点单个种类文章
public let hotspotGetAllByParamUrl:String = "http://app.100xuexi.com/app/TalkHandler/TalkQuery.ashx?method=GetAllByParam3&noCache=1&CategoryID=43&deviceNo=ios&pageIndex=1&pageSize=10&studyNumber=2742573&type=0"

