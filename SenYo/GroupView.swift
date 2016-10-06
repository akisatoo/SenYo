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
    let logoImageView = UIImageView( image: UIImage(named: "logo"))
    var itemArray : NSArray = ["グループ１", "グループ２"]
    required init(){
        super.init( frame : CGRectMake(0, 0, 0, 0))
        self.backgroundColor = UIColor.whiteColor()
        self.frame = CGRectMake(0, 0,  myBoundSize.width / 2 + 50, myBoundSize.height )
        myTableView.scrollEnabled = false
        myTableView.registerClass( UITableViewCell.self, forCellReuseIdentifier: "MyCell")
        myTableView.separatorColor = UIColor.redColor()
        myTableView.dataSource = self
        myTableView.delegate = self
        //myTableView.layer.borderWidth = 2.0
        //myTableView.layer.borderColor = UIColor.blueColor().CGColor
        // addSubView
        self.addSubview(logoImageView)
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
        let myImageView = UIImageView(image: UIImage(named: "group"))
        let textLabel = UILabel()
        textLabel.text = self.itemArray[indexPath.row] as? String
        cell.backgroundColor = UIColor.clearColor()
        cell.addSubview(myImageView)
        cell.addSubview(textLabel)
        myImageView.autoPinEdgeToSuperviewEdge(.Top, withInset : 10)
        myImageView.autoPinEdgeToSuperviewEdge(.Left, withInset : 20 )
        textLabel.autoPinEdgeToSuperviewEdge(.Top, withInset : 10 )
        textLabel.autoPinEdge(.Left, toEdge: .Right, ofView: myImageView, withOffset: 10)
        //cell.textLabel?.font = UIFont.systemFontOfSize(18)
        return cell
    }
    
    func setAutoLayout (){
        // autoLayout
        logoImageView.autoSetDimensionsToSize(CGSizeMake( 150, 40 ))
        logoImageView.autoPinEdgeToSuperviewEdge(.Top, withInset: 100 )
        logoImageView.autoPinEdgeToSuperviewEdge(.Left, withInset: 50 )
        myTableView.autoSetDimensionsToSize(CGSizeMake(myBoundSize.width / 2, 300 ))
        myTableView.autoPinEdgeToSuperviewEdge(.Right, withInset: 20 )
        myTableView.autoPinEdge(.Top, toEdge: .Bottom, ofView: logoImageView, withOffset: 20)
    }

}