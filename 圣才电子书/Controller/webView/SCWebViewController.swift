//
//  SCWebViewController.swift
//  SCDZS
//
//  Created by 周磊 on 16/7/5.
//  Copyright © 2016年 周磊. All rights reserved.
//

import UIKit

class SCWebViewController: SCBaseViewController {

    var url:String!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
        self.searchBtn.hidden = true
        self.homeBtn.hidden = true
        
        self.view.backgroundColor = RGB(245, g: 245, b: 245)
        
        self.view.addSubview(myWebView)
        
        //因为不同url加载的数据内容不同，有的带广告，有的不带，所以此处区分一下然后给不同的frame，防止遮挡住或超出新闻内容
        if url.containsString("100xuexi") {
            
            if url.containsString("Categoryid") {
                myWebView.snp.makeConstraints { (make) in
                    make.bottom.left.right.equalTo(self.view).offset(0)
                    make.top.equalTo(self.view).offset(45)
                }
                
            }else {
                myWebView.snp.makeConstraints { (make) in
                    make.bottom.left.right.equalTo(self.view).offset(0)
                    make.top.equalTo(self.view).offset(-20)
                }
            }
        }else {
            
            myWebView.snp.makeConstraints { (make) in
                make.bottom.left.right.equalTo(self.view).offset(0)
                make.top.equalTo(self.view).offset(45)
            }
        }
        //让导航栏视图在最上层
        self.view.bringSubviewToFront(self.titleView)
         //偶尔有几个传过来的url字符串包含\n，所以这里去除掉首尾的空白字符和换行字符
        url =   url.stringByTrimmingCharactersInSet(NSCharacterSet.whitespaceAndNewlineCharacterSet())
        let request:NSURLRequest = NSURLRequest(URL: NSURL(string: url)!)
        myWebView.loadRequest(request)
        
    }
    lazy var myWebView:UIWebView = {
        
       var myWebView = UIWebView()
        myWebView.delegate = self
        myWebView.backgroundColor = RGB(245, g: 245, b: 245)
        return myWebView
    }()
    
    override func clickBack() {
        // 能否返回上一级，能就返回上一级，不能就返回主界面
        if self.myWebView.canGoBack {
            
            self.myWebView.goBack()
        }else {
            self.navigationController?.popViewControllerAnimated(true)
        }
    }
}
extension SCWebViewController: UIWebViewDelegate {
    
    func webViewDidStartLoad(webView: UIWebView) {
        //开始加载网页时显示loading框
        self.showHUD()
    }
    func webViewDidFinishLoad(webView: UIWebView)  {
        //当网页加载完成后，消失loading框和提示语
        self.hideHUD()
        //有广告，此处屏蔽掉广告
        webView.stringByEvaluatingJavaScriptFromString("document.documentElement.getElementsByClassName('DownloadAppTips')[0].style.display = 'none'")
    }
    
    func webView(webView: UIWebView, didFailLoadWithError error: NSError?)  {
        //当网页加载失败时，消失loading框，显示提示语
        self.hideHUD()
        self.showErrorHUDWithMessage("报告老大,这个网页打不开")
    }
}