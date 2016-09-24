//
//  NoticeView.swift
//  SenYo
//
//  Created by takahashi akisato on 2016/08/31.
//  Copyright © 2016年 takahashi akisato. All rights reserved.
//

import UIKit
import PureLayout

protocol NoticeViewDelegate: NSObjectProtocol {}

class NoticeView: UIView {
    var delegate: NoticeViewDelegate?
    
    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    required init() {
        super.init(frame: CGRectMake(0, 0, 0, 0));
        self.backgroundColor = UIColor.greenColor()
        
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
    }
    
}