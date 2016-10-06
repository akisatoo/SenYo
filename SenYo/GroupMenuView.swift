//
//  groupMenuView.swift
//  SenYo
//
//  Created by takahashi akisato on 2016/09/25.
//  Copyright © 2016年 takahashi akisato. All rights reserved.
//

import Foundation
import UIKit
import PureLayout

protocol GroupMenuViewDelegate: NSObjectProtocol {
    func chooseCell( sender : Int )
}

class GroupMenuView: UIView, UITableViewDelegate, UITableViewDataSource {
    var delegate: GroupMenuViewDelegate?
    var mainView: UIView?
    var myTableView = UITableView()
    var itemArray : NSArray = ["AAAAaaaaaaaaaaaaaaaaaaaaA", "BBBBBB"]
    
    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    required init() {
        super.init(frame: CGRectMake(0, 0, 0, 0));
        self.mainView = UIView()
        self.mainView!.backgroundColor = UIColor.whiteColor()
        self.mainView!.layer.frame = CGRectMake(0, 0, myBoundSize.width, myBoundSize.height)
        self.mainView!.layer.position = CGPointMake(myBoundSize.width/4, myBoundSize.height/2)
        //self.mainView!.userInteractionEnabled = true
        self.addSubview(self.mainView!)
        
        let displayWidth: CGFloat = myBoundSize.width
        let displayHeight: CGFloat = myBoundSize.height
        myTableView = UITableView(frame: CGRect(x: 0, y: 64, width: displayWidth - myBoundSize.width * 0.25, height: displayHeight))
        myTableView.registerClass(UITableViewCell.self, forCellReuseIdentifier: "MyCell")
        myTableView.dataSource = self
        myTableView.delegate = self
        self.addSubview(myTableView)
    }
    
    
    override func layoutSubviews() {
        super.layoutSubviews()
    }
    
    //総数を返す
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        // print("Num: \(indexPath.row)")
        //print("Value: \(self.myItem[indexPath.row])")
        self.delegate?.chooseCell(indexPath.row)
    }
    /*
    Cellの総数を返すデータソースメソッド.
    (実装必須)
    */
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.itemArray.count
    }
    
    /*
    Cellに値を設定するデータソースメソッド.
    (実装必須)
    */
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        // 再利用するCellを取得する.
        let cell = tableView.dequeueReusableCellWithIdentifier("MyCell", forIndexPath: indexPath)
        
        // Cellに値を設定する.
        cell.textLabel!.text = "\(self.itemArray[indexPath.row])"
        
        return cell
    }
    
}