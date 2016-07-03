//
//  SCHomeViewController.swift
//  圣才电子书
//
//  Created by 周磊 on 16/6/13.
//  Copyright © 2016年 周磊. All rights reserved.
//

import UIKit
import RxSwift

class SCHomeViewController: SCBaseViewController {

    lazy var homeTitleView:SCHomeTitleView = {
        
        let homeTitleView = SCHomeTitleView.init()
        homeTitleView.backgroundColor = UIColor.whiteColor()
          return homeTitleView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.titleLabel.text = "首页"
        self.view.backgroundColor = BgColor
        self.titleView.hidden = true
        
        self.view.addSubview(self.homeTitleView)
        self.homeTitleView.snp.makeConstraints { (make) in
            make.top.left.right.equalTo(self.view).offset(0)
            make.height.equalTo(NavigationH)
            
        }
        
        homeTitleView.homeRichScan.rac_signalForControlEvents(UIControlEvents.TouchUpInside).subscribeNext { (value) in
            SCLog("点击了扫一扫")
            self.navigationController?.pushViewController(SCLkkViewController(), animated: true)
        }
        
        homeTitleView.homeSchoolmate.rac_signalForControlEvents(UIControlEvents.TouchUpInside).subscribeNext { (value) in
            SCLog("点击了学友群")
        }

        homeTitleView.homeSearchBoxVoice.rac_signalForControlEvents(UIControlEvents.TouchUpInside).subscribeNext { (value) in
           SCLog("点击了语音")
        }
        
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    
    
}
