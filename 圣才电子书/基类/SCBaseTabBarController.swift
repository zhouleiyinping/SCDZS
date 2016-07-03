//
//  SCBaseTabBarController.swift
//  圣才电子书
//
//  Created by 周磊 on 16/6/13.
//  Copyright © 2016年 周磊. All rights reserved.
//

import UIKit

class SCBaseTabBarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()

        setUpTabBarViewControllew()
    
        
        
    }

    /**初始化tabbar*/
    func setUpTabBarViewControllew(){
        
        tabBaraAddChildViewController(SCHomeViewController(), image: ResizeImage(UIImage(named:"001_1主页_首页")!), selectedImage: ResizeImage(UIImage(named:"001_1主页_首页（选中）")!), title: "首页")
        
        tabBaraAddChildViewController(SCE_BookViewController(), image: ResizeImage(UIImage(named:"001_1主页_消息")!), selectedImage: ResizeImage(UIImage(named:"001_1主页_消息（选中）")!), title: "电子书")
        
        tabBaraAddChildViewController(SCFriendViewController(), image: ResizeImage(UIImage(named:"001_1主页_朋友圈")!), selectedImage: ResizeImage(UIImage(named:"001_1主页_朋友圈（选中）")!), title: "朋友圈")
        
        tabBaraAddChildViewController(SCFindViewController(), image: ResizeImage(UIImage(named:"001_1主页_发现")!), selectedImage: ResizeImage(UIImage(named:"001_1主页_发现（选中）")!), title: "发现")
        
        tabBaraAddChildViewController(SCMyCenterViewController(), image: ResizeImage(UIImage(named:"001_1主页_我的")!), selectedImage: ResizeImage(UIImage(named:"001_1主页_我的（选中）")!), title: "我")
    }
    
    /**设置tabbar*/
    func tabBaraAddChildViewController(vc:UIViewController,image:UIImage,selectedImage:UIImage,title:String){
        
        vc.tabBarItem.image = image.imageWithRenderingMode(UIImageRenderingMode.AlwaysOriginal)
        vc.tabBarItem.selectedImage = selectedImage.imageWithRenderingMode(UIImageRenderingMode.AlwaysOriginal)
        vc.title = title
        /**设置title字体颜色*/
        UITabBarItem.appearance().setTitleTextAttributes(
            [NSForegroundColorAttributeName: UIColor.init(red: 9/255, green: 186/255, blue: 7/255, alpha: 1)], forState:.Selected)
        let navi = BaseNavigationController.init(rootViewController: vc)
        self.addChildViewController(navi)
    }

    /**压缩图片*/
    func ResizeImage(image: UIImage) -> UIImage {
        
        let size = image.size
        let widthRatio  = 25  / image.size.width
        let heightRatio = 25 / image.size.height
        
        var newSize: CGSize
        if(widthRatio > heightRatio) {
            newSize = CGSizeMake(size.width * heightRatio, size.height * heightRatio)
        } else {
            newSize = CGSizeMake(size.width * widthRatio,  size.height * widthRatio)
        }
        
        let rect = CGRectMake(0, 0, newSize.width, newSize.height)
        
        UIGraphicsBeginImageContextWithOptions(newSize, false, 1.0)
        image.drawInRect(rect)
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        return newImage
    }

   
}
