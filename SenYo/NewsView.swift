//
//  NewsView.swift
//  SenYo
//
//  Created by 松江飛雄馬 on 2016/09/02.
//  Copyright © 2016年 takahashi akisato. All rights reserved.
//

import Foundation
import UIKit

protocol NewsViewDelegate : NSObjectProtocol {
    func moveViews( num : Int )
}

class NewsView : UIView, UITableViewDataSource, UITableViewDelegate {
    private var myTableView : UITableView!
    var delegate : NewsViewDelegate?
    private let myItem : NSArray = [ "test1", "招待", "test3"]
    //
    required init () {
        super.init( frame : CGRectMake(0,0, 0, 0))
        self.backgroundColor = UIColor.blackColor()
        let displayWidth: CGFloat = myBoundSize.width
        let displayHeight: CGFloat = myBoundSize.height
        let barHeight: CGFloat = UIApplication.sharedApplication().statusBarFrame.size.height
        myTableView = UITableView(frame: CGRect(x: 0, y: barHeight, width: displayWidth, height: displayHeight - barHeight))
        myTableView.registerClass(UITableViewCell.self, forCellReuseIdentifier: "MyCell")
        myTableView.dataSource = self
        myTableView.delegate = self
        self.addSubview(myTableView)
    }
    //
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    override func layoutSubviews() {
        super.layoutSubviews()
    }
    //総数を返す
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        print("Num: \(indexPath.row)")
        print("Value: \(self.myItem[indexPath.row])")
        self.delegate?.moveViews(indexPath.row)
    }
    /*
    Cellの総数を返すデータソースメソッド.
    (実装必須)
    */
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.myItem.count
    }
    
    /*
    Cellに値を設定するデータソースメソッド.
    (実装必須)
    */
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        // 再利用するCellを取得する.
        let cell = tableView.dequeueReusableCellWithIdentifier("MyCell", forIndexPath: indexPath)
        
        // Cellに値を設定する.
        cell.textLabel!.text = "\(self.myItem[indexPath.row])"
        
        return cell
    }


}