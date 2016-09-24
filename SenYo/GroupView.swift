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

protocol GroupViewDelegate : NSObjectProtocol {
    func chooseCell( sender : Int )
}

class GroupView : UIView, UITableViewDelegate, UITableViewDataSource {
    var delegate : GroupViewDelegate?
    var myTableView = UITableView()
    var itemArray : NSArray = ["AAAAA", "BBBBBB"]
    required init(){
        super.init( frame : CGRectMake(0, 0, 0, 0))
        self.backgroundColor = UIColor.whiteColor()
        myTableView.scrollEnabled = false
        myTableView.registerClass( UITableViewCell.self, forCellReuseIdentifier: "MyCell")
        //myTableView.separatorColor = UIColor.redColor()
        myTableView.dataSource = self
        myTableView.delegate = self
        self.addSubview(myTableView)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //選択されたCell
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath){
        self.delegate?.chooseCell( indexPath.row )
    }
    
    //Cellの総数を返すデータソースメソッド.
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.itemArray.count
    }
    
    //Cellに値を設定するデータソースメソッド.
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("MyCell", forIndexPath: indexPath)
        let textLabel = UILabel()
        textLabel.text = self.itemArray[indexPath.row] as? String
        cell.backgroundColor = UIColor.clearColor()
        cell.addSubview(textLabel)
        textLabel.autoPinEdgeToSuperviewEdge(.Top, withInset : 10 )
        textLabel.autoPinEdgeToSuperviewEdge(.Left, withInset : 50 )
        //cell.textLabel?.font = UIFont.systemFontOfSize(18)
        return cell
    }
    
    func setAutoLayout (){
        //autolayout
        self.autoSetDimensionsToSize(CGSizeMake( myBoundSize.width / 3 , myBoundSize.height ))
        self.autoPinEdgeToSuperviewEdge(.Right, withInset : 0)
        self.autoPinEdgeToSuperviewEdge(.Top, withInset : 65)
        myTableView.autoSetDimensionsToSize(CGSizeMake(140, 140))
        myTableView.autoPinEdgeToSuperviewEdge(.Right, withInset : 0)
        myTableView.autoPinEdgeToSuperviewEdge(.Top, withInset : 10)
        
    }

}