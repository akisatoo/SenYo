//
//  NoticeView.swift
//  SenYo
//
//  Created by takahashi akisato on 2016/08/31.
//  Copyright © 2016年 takahashi akisato. All rights reserved.
//

import UIKit
import PureLayout

protocol GroupEditingViewDelegate: NSObjectProtocol {
}

class GroupEditingView: UIView {
    var delegate: GroupEditingViewDelegate?
    
    
    required init() {
        super.init(frame: CGRectMake(0, 0, 0, 0));
        self.backgroundColor = .whiteColor()
        let groupImg = UIImageView()
        let groupName = UITextField()
        let messageEdit = UIButton()
        let memberEdit = UIButton()
        let btn = UIButton()
        
        groupImg.layer.borderWidth = 2.0
        groupImg.layer.cornerRadius = 25
        groupImg.layer.borderColor = UIColor.redColor().CGColor
        
        groupName.layer.borderColor = UIColor.clearColor().CGColor
        groupName.text = "hoge"
        groupName.font = UIFont.boldSystemFontOfSize(12)
        
        memberEdit.backgroundColor = .redColor()
        memberEdit.tintColor = .whiteColor()
        memberEdit.setTitle("メンバーを編集 ✎", forState: .Normal)
        memberEdit.layer.cornerRadius = 20
        
        messageEdit.backgroundColor = .redColor()
        messageEdit.tintColor = .whiteColor()
        messageEdit.setTitle("メッセージを編集 ✎", forState: .Normal)
        messageEdit.layer.cornerRadius = 20
        
        
        btn.setTitle("hoge", forState: .Normal)
        
        self.addSubview(groupImg)
        self.addSubview(groupName)
        self.addSubview(messageEdit)
        self.addSubview(memberEdit)
        self.addSubview(btn)
        
        groupImg.autoSetDimensionsToSize(CGSizeMake(50,50))
        groupImg.autoPinEdgeToSuperviewEdge(.Left, withInset: myBoundSize.width / 2 - 25 )
        groupImg.autoPinEdgeToSuperviewEdge(.Top, withInset: 50 )
        
        
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
    }
    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}