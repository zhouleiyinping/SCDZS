//
//  SCLkkViewController.swift
//  圣才电子书
//
//  Created by 周磊 on 16/6/18.
//  Copyright © 2016年 周磊. All rights reserved.
//

import UIKit

class SCLkkViewController: SCBaseViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        self.view.backgroundColor = UIColor.yellowColor()
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        
        self.navigationController?.pushViewController(SCKllViewController(), animated: true)

        
    }
   

}
