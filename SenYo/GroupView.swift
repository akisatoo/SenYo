//
//  GroupView.swift
//  SenYo
//
//  Created by 松江飛雄馬 on 2016/09/25.
//  Copyright © 2016年 takahashi akisato. All rights reserved.
//

import Foundation
import UIKit
import PureLayout
import SwiftyJSON
import Alamofire

protocol GroupViewDelegate : NSObjectProtocol {
    //func chooseCell( sender : Int )
}

class GroupView : UIView, UITableViewDelegate, UITableViewDataSource {
    var delegate : GroupViewDelegate?
    let aspect = Aspect()
    var myTableView = UITableView()
    let groupMakeButton = UIButton()
    let logoImageView = UIImageView( image: UIImage(named: "logo"))
    var itemArray : NSArray = []
    var groupObjects : [JSON] = []
    required init(){
        super.init( frame : CGRectMake(0, 0, 0, 0))
        self.backgroundColor = UIColor.whiteColor()
        self.frame = CGRectMake(0, 0,  ( myBoundSize.width / 2 + 50 ) * aspect.xAspect(), myBoundSize.height )
        myTableView.scrollEnabled = false
        myTableView.registerClass( UITableViewCell.self, forCellReuseIdentifier: "MyCell")
        //myTableView.separatorColor = UIColor.redColor()
        myTableView.dataSource = self
        myTableView.delegate = self
        groupMakeButton.setTitle("新規グループ作成 ＋", forState: .Normal)
        groupMakeButton.setTitleColor(UIColor(red: 0.2, green: 0.8, blue: 1, alpha: 1), forState: .Normal)
        groupMakeButton.setTitleColor(.redColor(), forState: .Highlighted)
        
        // addSubView
        self.addSubview(logoImageView)
        self.addSubview(myTableView)
        self.addSubview(groupMakeButton)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //選択されたCell
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath){
       // self.delegate?.chooseCell( indexPath.row )
    }
    
    //Cellの総数を返すデータソースメソッド.
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.groupObjects.count
    }
    
    //Cellに値を設定するデータソースメソッド.
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("MyCell", forIndexPath: indexPath)
        let myImageView = UIImageView(image: UIImage(named: "group"))
        let textLabel = UILabel()
        textLabel.text = String(self.groupObjects[indexPath.row]["name"])
        cell.backgroundColor = UIColor.clearColor()
        cell.addSubview(myImageView)
        cell.addSubview(textLabel)
        myImageView.autoPinEdgeToSuperviewEdge(.Top, withInset : 10 * aspect.yAspect())
        myImageView.autoPinEdgeToSuperviewEdge(.Left, withInset : 20 * aspect.xAspect() )
        textLabel.autoPinEdgeToSuperviewEdge(.Top, withInset : 10 * aspect.yAspect() )
        textLabel.autoPinEdge(.Left, toEdge: .Right, ofView: myImageView, withOffset: 10 * aspect.xAspect())
        //cell.textLabel?.font = UIFont.systemFontOfSize(18)
        return cell
    }
    
    func setAutoLayout (){
        // autoLayout
        logoImageView.autoSetDimensionsToSize(CGSizeMake( 150 * aspect.xAspect(), 40 * aspect.yAspect() ))
        logoImageView.autoPinEdgeToSuperviewEdge(.Top, withInset: 100 * aspect.yAspect())
        logoImageView.autoPinEdgeToSuperviewEdge(.Left, withInset: 50 * aspect.xAspect() )
        myTableView.autoSetDimensionsToSize(CGSizeMake((myBoundSize.width / 2) * aspect.xAspect(), 300 * aspect.yAspect()))
        myTableView.autoPinEdgeToSuperviewEdge(.Right, withInset: 20 * aspect.xAspect() )
        myTableView.autoPinEdge(.Top, toEdge: .Bottom, ofView: logoImageView, withOffset: 20 * aspect.yAspect())
        groupMakeButton.autoSetDimensionsToSize(CGSizeMake(200, 30))
        // groupMakeButton.autoPinEdge(.Top, toEdge: .Bottom, ofView: self.myTableView, withOffset: 30 )
        groupMakeButton.autoPinEdgeToSuperviewEdge(.Bottom, withInset: 30)
        groupMakeButton.autoPinEdgeToSuperviewEdge(.Left, withInset: 20 )
    }
    
    // setter
    func setGroupData( data : [JSON] ){
        groupObjects = data
        myTableView.reloadData()
    }
    
}