//
//  MenuView.swift
//  SenYo
//
//  Created by 松江飛雄馬 on 2016/09/25.
//  Copyright © 2016年 takahashi akisato. All rights reserved.
//

import Foundation
import UIKit
import PureLayout

protocol MenuViewDelegate : NSObjectProtocol {
    func chooseCell( sender : Int )
}
class MenuView : UIView, UITableViewDataSource, UITableViewDelegate {
    var delegate : MenuViewDelegate?
    let aspect = Aspect()
    var itemArray : NSArray = ["お知らせ","ユーザ編集","ログアウト"]
    var itemNames : NSArray = ["bell", "gear", "door"]
    var myTableView = UITableView()
    required init(){
        super.init(frame:CGRectMake(0, 0, 0, 0))
        self.backgroundColor = UIColor.whiteColor()
        self.layer.masksToBounds = true
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
        let imageViews = UIImageView(image : UIImage( named: itemNames[indexPath.row] as! String))
        cell.backgroundColor = UIColor.clearColor()
        cell.addSubview(textLabel)
        cell.addSubview(imageViews)
        textLabel.autoPinEdgeToSuperviewEdge(.Top, withInset : 10 * aspect.yAspect() )
        textLabel.autoPinEdgeToSuperviewEdge(.Left, withInset : 50 * aspect.xAspect() )
        imageViews.autoSetDimensionsToSize(CGSizeMake( 18 * aspect.xAspect(), 18 * aspect.yAspect()))
        imageViews.autoPinEdgeToSuperviewEdge(.Top, withInset : 12 * aspect.yAspect())
        imageViews.autoPinEdgeToSuperviewEdge(.Left, withInset : 15 * aspect.xAspect() )
        //cell.textLabel?.font = UIFont.systemFontOfSize(18)
        return cell
    }
    
    func setAutoLayout (){
        //autolayout
        self.autoSetDimensionsToSize(CGSizeMake(150 * aspect.xAspect(), 150 * aspect.yAspect()))
        self.autoPinEdgeToSuperviewEdge(.Right, withInset : 0)
        self.autoPinEdgeToSuperviewEdge(.Top, withInset : 65 * aspect.yAspect() )
        myTableView.autoSetDimensionsToSize(CGSizeMake(140 * aspect.xAspect(), 140 * aspect.yAspect()))
        myTableView.autoPinEdgeToSuperviewEdge(.Right, withInset : 0)
        myTableView.autoPinEdgeToSuperviewEdge(.Top, withInset : 10 * aspect.yAspect())
        
    }
    
}