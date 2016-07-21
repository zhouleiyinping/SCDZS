//
//  SCE_BookOpenViewController.swift
//  SCDZS
//
//  Created by 周磊 on 16/7/19.
//  Copyright © 2016年 周磊. All rights reserved.
//

import UIKit
import FolioReaderKit


class SCE_BookOpenViewController: SCBaseViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        self.view.backgroundColor = BgColor
        // Do any additional setup after loading the view.
         open()
        
    }
    
    func open() {
        let config = FolioReaderConfig()
        let bookPath = NSBundle.mainBundle().pathForResource("沧海", ofType: "epub")
        FolioReader.presentReader(parentViewController: self, withEpubPath: bookPath!, andConfig: config)
    }
    
}
